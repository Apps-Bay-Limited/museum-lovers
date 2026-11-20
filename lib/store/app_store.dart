import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:museumLovers/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A user-created, named list of artworks ("board"), independent of
/// favorites — an artwork can live in any number of collections.
class ArtCollection {
  ArtCollection({required this.id, required this.name, List<Art>? items}) : items = items ?? <Art>[];

  final String id;
  String name;
  final List<Art> items;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'items': <Map<String, dynamic>>[for (final Art art in items) art.toJson()],
      };

  factory ArtCollection.fromJson(Map<String, dynamic> json) => ArtCollection(
        id: json['id'] as String,
        name: json['name'] as String,
        items: <Art>[
          for (final dynamic item in json['items'] as List<dynamic>) Art.fromJson(item as Map<String, dynamic>),
        ],
      );
}

/// Holds user-local state: favorite artworks, collections, recent searches,
/// and small usage stats (quiz results, ad-free grants).
/// Persisted to [SharedPreferences].
class AppStore extends ChangeNotifier {
  AppStore(this._prefs) {
    _load();
  }

  static const String _favoritesKey = 'favorite_arts';
  static const String _favoriteArtistsKey = 'favorite_artists';
  static const String _recentSearchesKey = 'recent_searches';
  static const String _recentlyViewedKey = 'recently_viewed_arts';
  static const String _collectionsKey = 'art_collections';
  static const String _quizBestScoreKey = 'quiz_best_score';
  static const String _quizBestTotalKey = 'quiz_best_total';
  static const String _quizGamesPlayedKey = 'quiz_games_played';
  static const String _adFreeUntilKey = 'ad_free_until';
  static const int maxRecentSearches = 10;
  static const int maxRecentlyViewed = 20;

  final SharedPreferences _prefs;

  final Map<String, Art> _favorites = <String, Art>{};
  final Map<String, ArtMaker> _favoriteArtists = <String, ArtMaker>{};
  final List<String> _recentSearches = <String>[];
  final List<Art> _recentlyViewed = <Art>[];
  final Map<String, ArtCollection> _collections = <String, ArtCollection>{};

  int _quizBestScore = 0;
  int _quizBestTotal = 0;
  int _quizGamesPlayed = 0;
  DateTime? _adFreeUntil;

  /// Favorite artworks in the order they were added.
  List<Art> get favorites => List<Art>.unmodifiable(_favorites.values);

  /// Favorite artists in the order they were added.
  List<ArtMaker> get favoriteArtists => List<ArtMaker>.unmodifiable(_favoriteArtists.values);

  List<String> get recentSearches => List<String>.unmodifiable(_recentSearches);

  /// Recently viewed artworks, most recent first.
  List<Art> get recentlyViewed => List<Art>.unmodifiable(_recentlyViewed);

  bool isFavorite(Art art) => _favorites.containsKey(art.id);

  void toggleFavorite(Art art) {
    if (isFavorite(art)) {
      _favorites.remove(art.id);
    } else {
      _favorites[art.id] = art;
    }
    notifyListeners();
    _saveFavorites();
  }

  /// Artists without a resolved Person [ArtMaker.id] (e.g. "Anonymous") can't
  /// be favorited — there's nothing stable to key them by.
  bool isFavoriteArtist(ArtMaker artist) {
    final String? id = artist.id;
    return id != null && _favoriteArtists.containsKey(id);
  }

  void toggleFavoriteArtist(ArtMaker artist) {
    final String? id = artist.id;
    if (id == null) {
      return;
    }
    if (_favoriteArtists.containsKey(id)) {
      _favoriteArtists.remove(id);
    } else {
      _favoriteArtists[id] = artist;
    }
    notifyListeners();
    _saveFavoriteArtists();
  }

  void addRecentlyViewed(Art art) {
    _recentlyViewed.removeWhere((Art item) => item.id == art.id);
    _recentlyViewed.insert(0, art);
    if (_recentlyViewed.length > maxRecentlyViewed) {
      _recentlyViewed.removeLast();
    }
    notifyListeners();
    _saveRecentlyViewed();
  }

  void addRecentSearch(String term) {
    final String trimmed = term.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _recentSearches.remove(trimmed);
    _recentSearches.insert(0, trimmed);
    if (_recentSearches.length > maxRecentSearches) {
      _recentSearches.removeLast();
    }
    notifyListeners();
    _saveRecentSearches();
  }

  void clearRecentSearches() {
    if (_recentSearches.isEmpty) {
      return;
    }
    _recentSearches.clear();
    notifyListeners();
    _saveRecentSearches();
  }

  // ---------------------------------------------------------------------------
  // Collections ("boards")
  // ---------------------------------------------------------------------------

  /// Most recently created first.
  List<ArtCollection> get collections => List<ArtCollection>.unmodifiable(_collections.values.toList().reversed);

  ArtCollection createCollection(String name) {
    final String trimmed = name.trim();
    final String id = clock.now().microsecondsSinceEpoch.toString();
    final ArtCollection collection = ArtCollection(id: id, name: trimmed.isEmpty ? 'Untitled' : trimmed);
    _collections[id] = collection;
    notifyListeners();
    _saveCollections();
    return collection;
  }

  void renameCollection(String id, String name) {
    final ArtCollection? collection = _collections[id];
    final String trimmed = name.trim();
    if (collection == null || trimmed.isEmpty) {
      return;
    }
    collection.name = trimmed;
    notifyListeners();
    _saveCollections();
  }

  void deleteCollection(String id) {
    if (_collections.remove(id) == null) {
      return;
    }
    notifyListeners();
    _saveCollections();
  }

  bool isInCollection(String collectionId, Art art) =>
      _collections[collectionId]?.items.any((Art item) => item.id == art.id) ?? false;

  void toggleInCollection(String collectionId, Art art) {
    final ArtCollection? collection = _collections[collectionId];
    if (collection == null) {
      return;
    }
    final int index = collection.items.indexWhere((Art item) => item.id == art.id);
    if (index >= 0) {
      collection.items.removeAt(index);
    } else {
      collection.items.insert(0, art);
    }
    notifyListeners();
    _saveCollections();
  }

  // ---------------------------------------------------------------------------
  // Quiz stats
  // ---------------------------------------------------------------------------

  int get quizGamesPlayed => _quizGamesPlayed;

  /// The best run's score and total questions, or null if no quiz has been
  /// completed yet. Compared by fraction (not raw score) so a 4/4 run beats
  /// a 4/5 one.
  ({int score, int total})? get quizBestResult =>
      _quizBestTotal > 0 ? (score: _quizBestScore, total: _quizBestTotal) : null;

  void recordQuizResult({required int score, required int total}) {
    _quizGamesPlayed++;
    if (total > 0) {
      final bool isNewBest = _quizBestTotal == 0 || score / total > _quizBestScore / _quizBestTotal;
      if (isNewBest) {
        _quizBestScore = score;
        _quizBestTotal = total;
      }
    }
    notifyListeners();
    _prefs.setInt(_quizGamesPlayedKey, _quizGamesPlayed);
    _prefs.setInt(_quizBestScoreKey, _quizBestScore);
    _prefs.setInt(_quizBestTotalKey, _quizBestTotal);
  }

  // ---------------------------------------------------------------------------
  // Ad-free grant (e.g. after watching a rewarded ad)
  // ---------------------------------------------------------------------------

  bool get isAdFree => _adFreeUntil != null && clock.now().isBefore(_adFreeUntil!);

  DateTime? get adFreeUntil => _adFreeUntil;

  void grantAdFree(Duration duration) {
    _adFreeUntil = clock.now().add(duration);
    notifyListeners();
    _prefs.setInt(_adFreeUntilKey, _adFreeUntil!.millisecondsSinceEpoch);
  }

  void _load() {
    try {
      final String? favoritesJson = _prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        for (final dynamic item in json.decode(favoritesJson) as List<dynamic>) {
          final Art art = Art.fromJson(item as Map<String, dynamic>);
          _favorites[art.id] = art;
        }
      }
      final String? recentlyViewedJson = _prefs.getString(_recentlyViewedKey);
      if (recentlyViewedJson != null) {
        for (final dynamic item in json.decode(recentlyViewedJson) as List<dynamic>) {
          _recentlyViewed.add(Art.fromJson(item as Map<String, dynamic>));
        }
      }
      final String? favoriteArtistsJson = _prefs.getString(_favoriteArtistsKey);
      if (favoriteArtistsJson != null) {
        for (final dynamic item in json.decode(favoriteArtistsJson) as List<dynamic>) {
          final ArtMaker artist = ArtMaker.fromJson(item as Map<String, dynamic>);
          if (artist.id != null) {
            _favoriteArtists[artist.id!] = artist;
          }
        }
      }
      _recentSearches.addAll(_prefs.getStringList(_recentSearchesKey) ?? <String>[]);
      final String? collectionsJson = _prefs.getString(_collectionsKey);
      if (collectionsJson != null) {
        for (final dynamic item in json.decode(collectionsJson) as List<dynamic>) {
          final ArtCollection collection = ArtCollection.fromJson(item as Map<String, dynamic>);
          _collections[collection.id] = collection;
        }
      }
      _quizBestScore = _prefs.getInt(_quizBestScoreKey) ?? 0;
      _quizBestTotal = _prefs.getInt(_quizBestTotalKey) ?? 0;
      _quizGamesPlayed = _prefs.getInt(_quizGamesPlayedKey) ?? 0;
      final int? adFreeUntilMillis = _prefs.getInt(_adFreeUntilKey);
      if (adFreeUntilMillis != null) {
        _adFreeUntil = DateTime.fromMillisecondsSinceEpoch(adFreeUntilMillis);
      }
    } catch (_) {
      // Corrupted preferences — start fresh.
    }
    notifyListeners();
  }

  Future<void> _saveCollections() async {
    final String encoded = json.encode(<Map<String, dynamic>>[
      for (final ArtCollection collection in _collections.values) collection.toJson(),
    ]);
    await _prefs.setString(_collectionsKey, encoded);
  }

  Future<void> _saveFavorites() async {
    final String encoded = json.encode(<Map<String, dynamic>>[
      for (final Art art in _favorites.values) art.toJson(),
    ]);
    await _prefs.setString(_favoritesKey, encoded);
  }

  Future<void> _saveRecentlyViewed() async {
    final String encoded = json.encode(<Map<String, dynamic>>[
      for (final Art art in _recentlyViewed) art.toJson(),
    ]);
    await _prefs.setString(_recentlyViewedKey, encoded);
  }

  Future<void> _saveFavoriteArtists() async {
    final String encoded = json.encode(<Map<String, dynamic>>[
      for (final ArtMaker artist in _favoriteArtists.values) artist.toJson(),
    ]);
    await _prefs.setString(_favoriteArtistsKey, encoded);
  }

  Future<void> _saveRecentSearches() async {
    await _prefs.setStringList(_recentSearchesKey, _recentSearches);
  }
}
