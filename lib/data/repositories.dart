import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:http/http.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/util/image_url.dart';

/// Repository backed by the Rijksmuseum **Linked Art** data platform.
///
/// See https://data.rijksmuseum.nl/. The collection search
/// (`data.rijksmuseum.nl/search/collection`) returns object *ids* only, so each
/// grid item is resolved individually. Images live on `iiif.micr.io` (IIIF 3.0)
/// and require a two-hop resolve (object → VisualItem → DigitalObject). Results
/// are cached to keep repeat views cheap.
///
/// The API is keyed via the `x-api-key` header. [apiKey] may be empty (the
/// public endpoint tolerates anonymous access) but a key is recommended.
class HttpRijksRepository implements RijksRepository {
  HttpRijksRepository(this.client, {this.apiKey = ''});

  final Client client;
  final String apiKey;

  static String searchBase = 'https://data.rijksmuseum.nl/search/collection';
  static String idBase = 'https://id.rijksmuseum.nl';

  /// Items surfaced per app "page". Kept small because every item costs several
  /// requests to resolve (title + image hops).
  static int itemsPerPage = 20;

  /// Width (px) baked into stored IIIF image URLs; downsized per-widget via
  /// [artImageUrl].
  static int imageWidth = 1400;

  // AAT language ids used to pick English strings out of multilingual arrays.
  static const String _aatEnglish = 'http://vocab.getty.edu/aat/300388277';

  final Map<String, ArtDetail> _detailCache = <String, ArtDetail>{};
  final Map<String, Art> _artCache = <String, Art>{};
  final Map<String, String?> _imageCache = <String, String?>{};
  final Map<String, _SearchCursor> _cursors = <String, _SearchCursor>{};

  Map<String, String> get _headers => <String, String>{
        'Accept': 'application/ld+json',
        if (apiKey.isNotEmpty) 'x-api-key': apiKey,
      };

  @override
  Future<ArtDetail> fetch(String objectNumber) async {
    final ArtDetail? cached = _detailCache[objectNumber];
    if (cached != null) {
      return cached;
    }
    final Map<String, dynamic> obj = await _getObject(objectNumber);
    final ArtDetail detail = await _artDetailFromObject(objectNumber, obj);
    return _detailCache[objectNumber] = detail;
  }

  // The app's paging controllers (PagedDataController / PagedSearchDataController)
  // number pages starting at 1, not 0.
  static const int _firstPage = 1;

  /// The museum's own curated "Top 1000" masterpieces set, used for the
  /// Masterpieces browse category and to source Artwork of the Day.
  static const String topThousandSetId = 'https://id.rijksmuseum.nl/260214';

  @override
  Future<List<Art>> fetchAll({required int page, String type = 'painting', bool masterpieces = false}) async {
    final Map<String, String> query = masterpieces
        ? <String, String>{'memberOfSetId': topThousandSetId, 'imageAvailable': 'true'}
        : <String, String>{'type': type, 'imageAvailable': 'true'};
    final String cursorKey = masterpieces ? 'browse:masterpieces' : 'browse:$type';
    final String url = _buildSearchUrl(query);
    final _SearchCursor cursor = _cursorFor(cursorKey, url);
    if (page <= _firstPage) {
      _restart(cursor, url);
    }
    return _resolvePage(cursor, page);
  }

  @override
  Future<List<Art>> fetchSearchAll({required String term, required int page}) async {
    final _SearchCursor cursor = _cursorFor('search:$term', _buildSearchUrl(<String, String>{'creator': term}));
    if (page <= _firstPage) {
      final String mode = await _pickSearchMode(term);
      _restart(cursor, _buildSearchUrl(<String, String>{mode: term}));
    }
    return _resolvePage(cursor, page);
  }

  /// Tries [term] as a creator, then a title, then a free-text description
  /// match, and commits to the first that returns results. Falls back to
  /// `description` (a true free-text search) so unmatched terms still query
  /// something reasonable rather than silently returning nothing.
  static const List<String> _searchModes = <String>['creator', 'title', 'description'];

  Future<String> _pickSearchMode(String term) async {
    for (final String mode in _searchModes) {
      if (await _totalFor(<String, String>{mode: term}) > 0) {
        return mode;
      }
    }
    return _searchModes.last;
  }

  @override
  Future<List<Art>> fetchByColor({required String hex, required int page}) async =>
      // The Linked Art platform exposes no dominant-colour data.
      const <Art>[];

  // ---------------------------------------------------------------------------
  // Paging
  // ---------------------------------------------------------------------------

  _SearchCursor _cursorFor(String key, String initialUrl) =>
      _cursors[key] ??= _SearchCursor(initialUrl);

  void _restart(_SearchCursor cursor, String url) {
    cursor.ids.clear();
    cursor.nextUrl = url;
    cursor.exhausted = false;
  }

  Future<List<Art>> _resolvePage(_SearchCursor cursor, int page) async {
    final int zeroBased = page - _firstPage;
    final int need = (zeroBased + 1) * itemsPerPage;
    while (cursor.ids.length < need && !cursor.exhausted) {
      await _fillCursor(cursor);
    }
    if (zeroBased * itemsPerPage >= cursor.ids.length) {
      return const <Art>[];
    }
    final List<String> slice = cursor.ids.sublist(
      zeroBased * itemsPerPage,
      need.clamp(0, cursor.ids.length),
    );
    final List<Art?> resolved = await Future.wait(slice.map(_resolveArt));
    return resolved.whereType<Art>().toList();
  }

  Future<void> _fillCursor(_SearchCursor cursor) async {
    final String? url = cursor.nextUrl;
    if (url == null) {
      cursor.exhausted = true;
      return;
    }
    final Response response = await client.get(Uri.parse(url), headers: _headers);
    final Map<String, dynamic> body = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> items = (body['orderedItems'] as List<dynamic>?) ?? <dynamic>[];
    for (final dynamic item in items) {
      final String? id = (item as Map<String, dynamic>)['id'] as String?;
      if (id != null) {
        cursor.ids.add(_localId(id));
      }
    }
    final Object? next = body['next'];
    cursor.nextUrl = next is Map<String, dynamic> ? next['id'] as String? : null;
    if (cursor.nextUrl == null || items.isEmpty) {
      cursor.exhausted = true;
    }
  }

  Future<int> _totalFor(Map<String, String> params) async {
    final Response response = await client.get(Uri.parse(_buildSearchUrl(params)), headers: _headers);
    final Map<String, dynamic> body = json.decode(response.body) as Map<String, dynamic>;
    final Object? partOf = body['partOf'];
    if (partOf is Map<String, dynamic>) {
      return (partOf['totalItems'] as num?)?.toInt() ?? 0;
    }
    return ((body['orderedItems'] as List<dynamic>?)?.length) ?? 0;
  }

  String _buildSearchUrl(Map<String, String> params) =>
      Uri.parse(searchBase).replace(queryParameters: params).toString();

  // ---------------------------------------------------------------------------
  // Resolving a single object into an Art (grid item)
  // ---------------------------------------------------------------------------

  Future<Art?> _resolveArt(String localId) async {
    final Art? cached = _artCache[localId];
    if (cached != null) {
      return cached;
    }
    try {
      final Map<String, dynamic> obj = await _getObject(localId);
      final String? imageUrl = await _resolveImage(localId, obj);
      final ArtImage? image = imageUrl == null ? null : _imageFrom(imageUrl, obj);
      final Art art = Art(
        id: localId,
        objectNumber: localId,
        title: _title(obj),
        longTitle: _title(obj),
        principalOrFirstMaker: _makerName(obj),
        hasImage: image != null,
        showImage: image != null,
        webImage: image,
        headerImage: image,
        links: ArtLinks(web: _webPage(obj) ?? '$idBase/$localId'),
      );
      return _artCache[localId] = art;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> _getObject(String localId) async {
    final Response response = await client.get(Uri.parse('$idBase/$localId'), headers: _headers);
    return json.decode(response.body) as Map<String, dynamic>;
  }

  /// Object → VisualItem → DigitalObject → IIIF url. Returns a stored url at
  /// [imageWidth]; null when the object has no image.
  Future<String?> _resolveImage(String localId, Map<String, dynamic> obj) async {
    if (_imageCache.containsKey(localId)) {
      return _imageCache[localId];
    }
    String? result;
    try {
      final String? visualItemId = _firstId(obj['shows']);
      if (visualItemId != null) {
        final Map<String, dynamic> vi = await _getObject(_localId(visualItemId));
        final String? digitalId = _firstId(vi['digitally_shown_by']);
        if (digitalId != null) {
          final Map<String, dynamic> digital = await _getObject(_localId(digitalId));
          final String? accessPoint = _firstId(digital['access_point']);
          if (accessPoint != null) {
            result = artImageUrl(accessPoint, imageWidth);
          }
        }
      }
    } catch (_) {
      result = null;
    }
    return _imageCache[localId] = result;
  }

  // ---------------------------------------------------------------------------
  // Object → ArtDetail (detail page)
  // ---------------------------------------------------------------------------

  Future<ArtDetail> _artDetailFromObject(String localId, Map<String, dynamic> obj) async {
    final String? imageUrl = await _resolveImage(localId, obj);
    final ArtImage? image = imageUrl == null ? null : _imageFrom(imageUrl, obj);
    final List<_MakerRef> makerRefs = _makerRefs(obj);
    final String maker = makerRefs.isEmpty ? 'Anonymous' : makerRefs.map((_MakerRef r) => r.name).join(', ');
    final String title = _title(obj);
    final List<String> materials = _materials(obj);
    final String? medium = _referredText(obj, 'http://vocab.getty.edu/aat/300435429');
    final String? date = _productionDate(obj);

    return ArtDetail(
      id: localId,
      objectNumber: localId,
      colors: const <ArtColor>[],
      normalizedColors: const <ArtColor>[],
      title: title,
      titles: <String>[title],
      longTitle: <String?>[title, date].whereType<String>().where((String s) => s.isNotEmpty).join(', '),
      subTitle: <String?>[maker, date].whereType<String>().where((String s) => s.isNotEmpty).join(', '),
      scLabelLine: medium ?? materials.join(', '),
      label: ArtLabel(title: title, makerLine: maker, description: _referredText(obj, 'http://vocab.getty.edu/aat/300435416')),
      description: _referredText(obj, 'http://vocab.getty.edu/aat/300435416'),
      objectTypes: const <String>[],
      objectCollection: const <String>[],
      principalMaker: maker,
      principalOrFirstMaker: maker,
      principalMakers: makerRefs.isEmpty
          ? <ArtMaker>[
              const ArtMaker(
                name: 'Anonymous',
                unFixedName: 'Anonymous',
                occupation: <String>[],
                roles: <String>[],
                labelDesc: 'Anonymous',
              ),
            ]
          : <ArtMaker>[
              for (final _MakerRef ref in makerRefs)
                ArtMaker(
                  id: ref.id,
                  name: ref.name,
                  unFixedName: ref.name,
                  occupation: const <String>[],
                  roles: const <String>[],
                  labelDesc: ref.name,
                ),
            ],
      materials: materials,
      productionPlaces: const <String>[],
      techniques: _techniques(obj),
      physicalProperties: const <String>[],
      hasImage: image != null,
      showImage: image != null,
      historicalPersons: const <String>[],
      documentation: <String>[
        for (final String? t in <String?>[
          _referredText(obj, 'http://vocab.getty.edu/aat/300444174'), // provenance
          _referredText(obj, 'http://vocab.getty.edu/aat/300026687'), // acquisition
        ])
          if (t != null && t.isNotEmpty) t,
      ],
      dimensions: _dimensions(obj),
      physicalMedium: medium,
      webImage: image,
      dating: ArtDating(
        presentingDate: date ?? '',
        sortingDate: 0,
        period: 0,
        yearEarly: 0,
        yearLate: 0,
      ),
      plaqueDescriptionEnglish: _wallText(obj),
      inscriptions: _inscriptions(obj),
      galleryLocation: _galleryLocation(obj),
      onDisplay: obj['current_location'] != null,
    );
  }

  // ---------------------------------------------------------------------------
  // Object → ArtMaker (artist page)
  // ---------------------------------------------------------------------------

  final Map<String, ArtMaker> _artistCache = <String, ArtMaker>{};

  @override
  Future<ArtMaker> fetchArtist(String id) async {
    final String localId = _localId(id);
    final ArtMaker? cached = _artistCache[localId];
    if (cached != null) {
      return cached;
    }
    final Map<String, dynamic> person = await _getObject(localId);
    final ArtMaker artist = await _artistFromPerson(localId, person);
    return _artistCache[localId] = artist;
  }

  Future<ArtMaker> _artistFromPerson(String localId, Map<String, dynamic> person) async {
    final String name = _title(person);
    final List<String> occupation = await _occupations(person);
    final String? placeOfBirth = await _eventPlace(person['born']);
    final String? placeOfDeath = await _eventPlace(person['died']);
    return ArtMaker(
      id: localId,
      name: name,
      unFixedName: name,
      placeOfBirth: placeOfBirth,
      dateOfBirth: _eventDate(person['born']),
      placeOfDeath: placeOfDeath,
      dateOfDeath: _eventDate(person['died']),
      occupation: occupation,
      roles: const <String>[],
      biography: _referredText(person, _aatBiography),
      labelDesc: name,
    );
  }

  /// Parses birth/death dates, which may be a full `YYYY-MM-DD` or a
  /// partial `YYYY-MM`/`YYYY` (day/month default to 1 when missing).
  static DateTime? _parsePartialDate(String value) {
    final List<String> parts = value.split('-');
    final int? year = int.tryParse(parts[0]);
    if (year == null) {
      return null;
    }
    final int month = parts.length > 1 ? int.tryParse(parts[1]) ?? 1 : 1;
    final int day = parts.length > 2 ? int.tryParse(parts[2]) ?? 1 : 1;
    return DateTime(year, month, day);
  }

  DateTime? _eventDate(dynamic event) {
    if (event is! Map<String, dynamic>) {
      return null;
    }
    final Object? timespan = event['timespan'];
    if (timespan is! Map<String, dynamic>) {
      return null;
    }
    for (final dynamic n in (timespan['identified_by'] as List<dynamic>?) ?? const <dynamic>[]) {
      final String? content = (n as Map<String, dynamic>)['content'] as String?;
      if (content != null && content.isNotEmpty) {
        return _parsePartialDate(content);
      }
    }
    return null;
  }

  Future<String?> _eventPlace(dynamic event) async {
    if (event is! Map<String, dynamic>) {
      return null;
    }
    final String? placeId = _firstId(event['took_place_at']);
    if (placeId == null) {
      return null;
    }
    try {
      return _title(await _getObject(_localId(placeId)));
    } catch (_) {
      return null;
    }
  }

  /// Resolves up to 3 of the person's professional activities to human
  /// readable occupation labels. Capped to bound the number of extra
  /// requests an artist-page fetch makes.
  Future<List<String>> _occupations(Map<String, dynamic> person) async {
    final List<String> activityIds = <String>{
      for (final dynamic a in (person['carried_out'] as List<dynamic>?) ?? const <dynamic>[])
        if (_firstId((a as Map<String, dynamic>)['classified_as']) case final String id) id,
    }.take(3).toList();
    final List<Map<String, dynamic>?> activities = await Future.wait(
      activityIds.map((String id) async {
        try {
          return await _getObject(_localId(id));
        } catch (_) {
          return null;
        }
      }),
    );
    final List<String> labels = <String>[];
    for (final Map<String, dynamic>? activity in activities) {
      // Resolved Type objects carry their label under identified_by (like a
      // title), not notation (which is only used for values embedded inline).
      final String? label = activity == null ? null : _title(activity);
      if (label != null && label != 'Untitled' && !labels.contains(label)) {
        labels.add(label);
      }
    }
    return labels;
  }

  // ---------------------------------------------------------------------------
  // Linked Art field extraction helpers
  // ---------------------------------------------------------------------------

  ArtImage _imageFrom(String url, Map<String, dynamic> obj) {
    // Approximate the aspect ratio from physical dimensions (cm) when present.
    double width = 1;
    double height = 1;
    for (final dynamic dim in (obj['dimension'] as List<dynamic>?) ?? const <dynamic>[]) {
      final String? type = _classifiedLabel(dim as Map<String, dynamic>);
      final double? value = double.tryParse('${dim['value']}');
      if (value == null) {
        continue;
      }
      if (type == 'width') {
        width = value;
      } else if (type == 'height') {
        height = value;
      }
    }
    final double ratio = height > 0 ? width / height : 1;
    return ArtImage(guid: url, url: url, width: (ratio * 1000).round(), height: 1000);
  }

  String _title(Map<String, dynamic> obj) {
    final List<dynamic> names = (obj['identified_by'] as List<dynamic>?) ?? const <dynamic>[];
    String? fallback;
    for (final dynamic n in names) {
      final Map<String, dynamic> name = n as Map<String, dynamic>;
      if (name['type'] != 'Name') {
        continue;
      }
      final String? content = name['content'] as String?;
      if (content == null || content.isEmpty) {
        continue;
      }
      fallback ??= content;
      if (_hasLanguage(name['language'], _aatEnglish)) {
        return content;
      }
    }
    return fallback ?? 'Untitled';
  }

  /// Collects the distinct Person/Group nodes credited in `produced_by`,
  /// each with its Rijksmuseum Person id when present (enabling navigation
  /// to a full artist page).
  List<_MakerRef> _makerRefs(Map<String, dynamic> obj) {
    final List<_MakerRef> makers = <_MakerRef>[];
    void collect(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node['type'] == 'Person' || node['type'] == 'Group') {
          final String? name = _notation(node['notation']) ?? node['_label'] as String?;
          final String? id = node['id'] as String?;
          if (name != null && name.isNotEmpty && !makers.any((_MakerRef m) => m.name == name)) {
            makers.add(_MakerRef(name: name, id: id == null ? null : _localId(id)));
          }
        }
        for (final dynamic v in node.values) {
          collect(v);
        }
      } else if (node is List) {
        for (final dynamic v in node) {
          collect(v);
        }
      }
    }

    collect(obj['produced_by']);
    return makers;
  }

  String _makerName(Map<String, dynamic> obj) {
    final List<_MakerRef> refs = _makerRefs(obj);
    return refs.isEmpty ? 'Anonymous' : refs.map((_MakerRef r) => r.name).join(', ');
  }

  List<String> _materials(Map<String, dynamic> obj) => <String>[
        for (final dynamic m in (obj['made_of'] as List<dynamic>?) ?? const <dynamic>[])
          if (_notation((m as Map<String, dynamic>)['notation']) case final String s) s,
      ];

  List<String> _techniques(Map<String, dynamic> obj) {
    final Object? production = obj['produced_by'];
    if (production is! Map<String, dynamic>) {
      return const <String>[];
    }
    return <String>[
      for (final dynamic t in (production['technique'] as List<dynamic>?) ?? const <dynamic>[])
        if (_notation((t as Map<String, dynamic>)['notation']) case final String s) s,
    ];
  }

  // Getty AAT measurement-unit ids → display symbols.
  static const Map<String, String> _units = <String, String>{
    'http://vocab.getty.edu/aat/300379098': 'cm',
    'http://vocab.getty.edu/aat/300379097': 'mm',
    'http://vocab.getty.edu/aat/300379099': 'm',
    'http://vocab.getty.edu/aat/300379225': 'kg',
    'http://vocab.getty.edu/aat/300379226': 'g',
  };

  List<ArtDimension> _dimensions(Map<String, dynamic> obj) => <ArtDimension>[
        for (final dynamic d in (obj['dimension'] as List<dynamic>?) ?? const <dynamic>[])
          if (double.tryParse('${(d as Map<String, dynamic>)['value']}') case final double value)
            ArtDimension(
              unit: _units[((d['unit'] as Map<String, dynamic>?)?['id'] as String?)] ?? 'cm',
              type: _classifiedLabel(d) ?? 'size',
              value: value,
            ),
      ];

  String? _productionDate(Map<String, dynamic> obj) {
    final Object? production = obj['produced_by'];
    if (production is! Map<String, dynamic>) {
      return null;
    }
    final Object? timespan = production['timespan'];
    if (timespan is! Map<String, dynamic>) {
      return null;
    }
    final List<dynamic> names = (timespan['identified_by'] as List<dynamic>?) ?? const <dynamic>[];
    String? fallback;
    for (final dynamic n in names) {
      final Map<String, dynamic> name = n as Map<String, dynamic>;
      final String? content = name['content'] as String?;
      if (content == null) {
        continue;
      }
      fallback ??= content;
      if (_hasLanguage(name['language'], _aatEnglish)) {
        return content;
      }
    }
    return fallback;
  }

  /// Finds a `referred_to_by` entry classified as [aatId] and returns its
  /// English (or first) content.
  String? _referredText(Map<String, dynamic> obj, String aatId) {
    String? fallback;
    for (final dynamic r in (obj['referred_to_by'] as List<dynamic>?) ?? const <dynamic>[]) {
      final Map<String, dynamic> entry = r as Map<String, dynamic>;
      final bool matches = ((entry['classified_as'] as List<dynamic>?) ?? const <dynamic>[])
          .any((dynamic c) => (c as Map<String, dynamic>)['id'] == aatId);
      if (!matches) {
        continue;
      }
      final String? content = entry['content'] as String?;
      if (content == null || content.isEmpty) {
        continue;
      }
      fallback ??= content;
      if (_hasLanguage(entry['language'], _aatEnglish)) {
        return content;
      }
    }
    return fallback;
  }

  // Getty AAT ids used for detail-page fields not covered by _referredText
  // (which only looks at top-level referred_to_by entries).
  static const String _aatWallText = 'http://vocab.getty.edu/aat/300048722';
  static const String _aatInscription = 'http://vocab.getty.edu/aat/300435414';
  static const String _aatBiography = 'http://vocab.getty.edu/aat/300435422';

  /// The curator's wall-label text lives under `subject_of[].part[]`, not the
  /// top-level `referred_to_by` that [_referredText] searches — the English
  /// and Dutch versions are separate `subject_of` entries, so the language is
  /// read from the parent rather than the part itself.
  String? _wallText(Map<String, dynamic> obj) {
    String? fallback;
    for (final dynamic s in (obj['subject_of'] as List<dynamic>?) ?? const <dynamic>[]) {
      final Map<String, dynamic> subject = s as Map<String, dynamic>;
      final bool isEnglish = _hasLanguage(subject['language'], _aatEnglish);
      for (final dynamic p in (subject['part'] as List<dynamic>?) ?? const <dynamic>[]) {
        final Map<String, dynamic> part = p as Map<String, dynamic>;
        final bool matches = ((part['classified_as'] as List<dynamic>?) ?? const <dynamic>[])
            .any((dynamic c) => (c as Map<String, dynamic>)['id'] == _aatWallText);
        if (!matches) {
          continue;
        }
        final String? content = part['content'] as String?;
        if (content == null || content.isEmpty) {
          continue;
        }
        if (isEnglish) {
          return content;
        }
        fallback ??= content;
      }
    }
    return fallback;
  }

  /// Signatures and inscriptions, e.g. dated signatures on the work itself.
  /// Each fact is usually duplicated in Dutch and English; English is
  /// preferred, falling back to whatever language is available.
  List<String> _inscriptions(Map<String, dynamic> obj) {
    final List<String> english = <String>[];
    final List<String> any = <String>[];
    for (final dynamic r in (obj['referred_to_by'] as List<dynamic>?) ?? const <dynamic>[]) {
      final Map<String, dynamic> entry = r as Map<String, dynamic>;
      final bool matches = ((entry['classified_as'] as List<dynamic>?) ?? const <dynamic>[])
          .any((dynamic c) => (c as Map<String, dynamic>)['id'] == _aatInscription);
      if (!matches) {
        continue;
      }
      final String? content = entry['content'] as String?;
      if (content == null || content.isEmpty) {
        continue;
      }
      any.add(content);
      if (_hasLanguage(entry['language'], _aatEnglish)) {
        english.add(content);
      }
    }
    return english.isNotEmpty ? english : any;
  }

  /// Human-readable "building · gallery" string from `current_location`,
  /// e.g. "Main building · Gallery of Honour". Null when the object has no
  /// current location (typically meaning it's in storage, not on display).
  String? _galleryLocation(Map<String, dynamic> obj) {
    final Object? location = obj['current_location'];
    if (location is! Map<String, dynamic>) {
      return null;
    }
    for (final dynamic n in (location['identified_by'] as List<dynamic>?) ?? const <dynamic>[]) {
      final Map<String, dynamic> entry = n as Map<String, dynamic>;
      if (entry['type'] != 'Name' || !_hasLanguage(entry['language'], _aatEnglish)) {
        continue;
      }
      final List<String> parts = <String>[
        for (final dynamic p in (entry['part'] as List<dynamic>?) ?? const <dynamic>[])
          if ((p as Map<String, dynamic>)['content'] is String && (p['content'] as String).isNotEmpty)
            p['content'] as String,
      ];
      if (parts.isNotEmpty) {
        return parts.join(' · ');
      }
    }
    return null;
  }

  String? _webPage(Map<String, dynamic> obj) {
    for (final dynamic s in (obj['subject_of'] as List<dynamic>?) ?? const <dynamic>[]) {
      for (final dynamic d in ((s as Map<String, dynamic>)['digitally_carried_by'] as List<dynamic>?) ??
          const <dynamic>[]) {
        final String? url = _firstId((d as Map<String, dynamic>)['access_point']);
        if (url != null && url.contains('rijksmuseum.nl')) {
          return url;
        }
      }
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Small utilities
  // ---------------------------------------------------------------------------

  static String _localId(String idUrl) => idUrl.split('/').last;

  static String? _firstId(dynamic node) {
    if (node is List && node.isNotEmpty) {
      return (node.first as Map<String, dynamic>)['id'] as String?;
    }
    if (node is Map<String, dynamic>) {
      return node['id'] as String?;
    }
    return null;
  }

  static String? _notation(dynamic notation) {
    if (notation is! List) {
      return null;
    }
    String? fallback;
    for (final dynamic n in notation) {
      final Map<String, dynamic> entry = n as Map<String, dynamic>;
      final String? value = entry['@value'] as String?;
      if (value == null) {
        continue;
      }
      fallback ??= value;
      if (entry['@language'] == 'en') {
        return value;
      }
    }
    return fallback;
  }

  static String? _classifiedLabel(Map<String, dynamic> node) {
    for (final dynamic c in (node['classified_as'] as List<dynamic>?) ?? const <dynamic>[]) {
      final String? label = _notation((c as Map<String, dynamic>)['notation']) ?? c['_label'] as String?;
      if (label != null) {
        return label;
      }
    }
    return null;
  }

  static bool _hasLanguage(dynamic languages, String aatId) {
    if (languages is! List) {
      return false;
    }
    return languages.any((dynamic l) => (l as Map<String, dynamic>)['id'] == aatId);
  }
}

/// Mutable paging state for one search/browse query. The Rijksmuseum search
/// paginates by opaque `next` urls, so we buffer resolved ids and remember the
/// url of the next page.
class _SearchCursor {
  _SearchCursor(String initialUrl) : nextUrl = initialUrl;

  final List<String> ids = <String>[];
  String? nextUrl;
  bool exhausted = false;
}

/// A credited Person/Group, with its Rijksmuseum Person id when known.
class _MakerRef {
  const _MakerRef({required this.name, this.id});

  final String name;
  final String? id;
}

class DummyRijksRepository implements RijksRepository {
  @override
  Future<ArtDetail> fetch(String objectNumber) async {
    const int imageSize = 150;
    final List<ArtColor> colors = <ArtColor>[
      const ArtColor(percentage: 80, hex: '009688'),
      const ArtColor(percentage: 10, hex: '00a688'),
      const ArtColor(percentage: 10, hex: '00b688')
    ];
    return ArtDetail(
      id: objectNumber,
      objectNumber: objectNumber,
      colors: colors,
      normalizedColors: colors,
      title: 'Lorem Ipsum ' * 5,
      titles: <String>['Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 10],
      longTitle: 'Lorem Ipsum ' * 10,
      subTitle: 'Lorem Ipsum ' * 8,
      scLabelLine: 'Lorem Ipsum ' * 5,
      label: ArtLabel(
        title: 'Lorem Ipsum ' * 2,
        description: 'Lorem Ipsum ' * 5,
        date: clock.now(),
        notes: 'Lorem Ipsum ' * 5,
        makerLine: 'Lorem Ipsum ' * 5,
      ),
      description: 'Lorem Ipsum ' * 15,
      principalMaker: 'Jeremiah Ogbomo',
      principalOrFirstMaker: 'Jeremiah Ogbomo',
      principalMakers: <ArtMaker>[
        ArtMaker(
          name: 'Rijk van Gupta',
          biography: 'Lorem Ipsum ' * 5,
          unFixedName: 'Gupta, Rijk van',
          placeOfBirth: 'India',
          dateOfBirth: clock.now(),
          placeOfDeath: 'Amsterdam',
          dateOfDeath: clock.now(),
          labelDesc: 'Lorem Ipsum ' * 2,
          nationality: 'Indian',
          occupation: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
          roles: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
        ),
      ],
      plaqueDescriptionEnglish: 'Lorem Ipsum ' * 5,
      materials: <String>['oil', 'canvas'],
      techniques: <String>['painting'],
      physicalProperties: <String>['canvas'],
      productionPlaces: <String>['Amsterdam'],
      hasImage: true,
      showImage: true,
      historicalPersons: <String>['Jeremiah'],
      documentation: <String>[
        'Lorem Ipsum ' * 5,
        'Lorem Ipsum ' * 5,
        'Lorem Ipsum ' * 5,
        'Lorem Ipsum ' * 5
      ],
      dimensions: <ArtDimension>[
        const ArtDimension(unit: 'cm', type: 'height', value: 234),
        const ArtDimension(unit: 'cm', type: 'width', value: 200),
        const ArtDimension(unit: 'kg', type: 'weight', value: 10),
      ],
      physicalMedium: 'oil on canvas',
      dating: const ArtDating(
          presentingDate: 'c. 1100',
          sortingDate: 1100,
          period: 12,
          yearEarly: 1100,
          yearLate: 1100),
      objectCollection: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      objectTypes: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      webImage: const ArtImage(
        guid: 'id',
        url: 'https://via.placeholder.com/$imageSize/009688/ffffff?text= ',
        width: imageSize,
        height: imageSize,
      ),
      inscriptions: <String>['Lorem Ipsum'],
      galleryLocation: 'Main building · Gallery of Honour',
      onDisplay: true,
    );
  }

  @override
  Future<List<Art>> fetchAll({required int page, String type = 'painting', bool masterpieces = false}) async {
    final List<String> colors = <String>['4DB6AC', '26A69A', '009688', '00897B', '00695C'];
    return List<Art>.generate(20, (int index) {
      const int imageSize = 150;
      final String backgroundColor = colors[(index % colors.length)];
      final String imageUrl =
          'https://via.placeholder.com/$imageSize/$backgroundColor/ffffff?text= ';
      return Art(
        objectNumber: '$index',
        id: '$index',
        hasImage: true,
        showImage: true,
        longTitle: 'Lorem Ipsum ' * 10,
        title: 'Lorem Ipsum ' * 5,
        principalOrFirstMaker: 'Lorem Ipsum',
        headerImage: ArtImage(guid: '$index', url: imageUrl, width: imageSize, height: imageSize),
        webImage: ArtImage(guid: '$index', url: imageUrl, width: imageSize, height: imageSize),
        links: const ArtLinks(web: 'https://google.com'),
      );
    });
  }

  @override
  Future<List<Art>> fetchSearchAll({required int page, required String term}) {
    // TODO: implement fetchSearchAll
    throw UnimplementedError();
  }

  @override
  Future<List<Art>> fetchByColor({required String hex, required int page}) => fetchAll(page: page);

  @override
  Future<ArtMaker> fetchArtist(String id) {
    // TODO: implement fetchArtist
    throw UnimplementedError();
  }
}
