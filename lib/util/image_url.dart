/// Size (in pixels) used for artwork thumbnails in grids.
const int kGridImageSize = 600;

/// Returns a variant of [url] scaled to [size] pixels wide.
///
/// Rijksmuseum images are served through a IIIF (image API 3.0) endpoint on
/// `iiif.micr.io`, where the requested size is encoded in the path, e.g.
/// `https://iiif.micr.io/<id>/full/max/0/default.jpg`. This rewrites the size
/// segment (the part between `/full/` and the next `/`) to `<size>,`.
///
/// For backwards compatibility it also handles the legacy Googleusercontent
/// `=s<px>` suffix. When [url] matches neither pattern the original is returned
/// unchanged.
String artImageUrl(String url, int size) {
  final RegExp iiifSize = RegExp(r'/full/[^/]+/');
  if (iiifSize.hasMatch(url)) {
    return url.replaceFirst(iiifSize, '/full/$size,/');
  }
  final RegExp suffix = RegExp(r'=s\d+$');
  if (suffix.hasMatch(url)) {
    return url.replaceFirst(suffix, '=s$size');
  }
  return url;
}
