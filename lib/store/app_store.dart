import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:museumLovers/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds user-local state: favorite artworks and recent searches.
/// Persisted to [SharedPreferences].
class AppStore extends ChangeNotifier {
  AppStore(this._prefs) {
    _load();
  }

  static const String _favoritesKey = 'favorite_arts';
  static const String _favoriteArtistsKey = 'favorite_artists';
  static const String _recentSearchesKey = 'recent_searches';
  static const String _recentlyViewedKey = 'recently_viewed_arts';
  static const int maxRecentSearches = 10;
  static const int maxRecentlyViewed = 20;

  final SharedPreferences _prefs;

  final Map<String, Art> _favorites = <String, Art>{};
  final Map<String, ArtMaker> _favoriteArtists = <String, ArtMaker>{};
  final List<String> _recentSearches = <String>[];
  final List<Art> _recentlyViewed = <Art>[];

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
    } catch (_) {
      // Corrupted preferences — start fresh.
    }
    notifyListeners();
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
