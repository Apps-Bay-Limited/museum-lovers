import './models.dart';

abstract class RijksRepository {
  Future<ArtDetail> fetch(String objectNumber);

  /// [type] selects a category (e.g. `painting`, `drawing`, `sculpture`).
  /// When [masterpieces] is true, [type] is ignored and the museum's curated
  /// Top 1000 set is browsed instead.
  Future<List<Art>> fetchAll({required int page, String type = 'painting', bool masterpieces = false});

  /// [type] optionally narrows the search to one category (e.g. `painting`),
  /// combined with [term] rather than replacing it.
  Future<List<Art>> fetchSearchAll({required int page, required String term, String? type});

  Future<List<Art>> fetchByColor({required String hex, required int page});

  /// Resolves a full artist biography by their Rijksmuseum Person id.
  Future<ArtMaker> fetchArtist(String id);
}
