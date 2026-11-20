import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_spinner.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.url,
    this.builder,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
  }) : super(key: key);

  final String url;
  final Widget Function(ImageProvider<Object>)? builder;
  final BoxFit fit;

  /// Caps the decoded bitmap's width (in physical pixels), so a thumbnail
  /// doesn't hold a full-resolution decoded image in memory. Pass the
  /// widget's actual rendered width (scaled by device pixel ratio) rather
  /// than the already-downsized network image size.
  final int? memCacheWidth;

  static const Key loadingKey = Key('loading');

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        key: Key(url),
        imageUrl: url,
        fit: fit,
        memCacheWidth: memCacheWidth,
        imageBuilder: builder != null ? (_, ImageProvider<Object> imageProvider) => builder!(imageProvider) : null,
        placeholder: (_, __) => const LoadingSpinner(key: loadingKey),
        errorWidget: (_, __, Object? ___) => const Center(child: Icon(Icons.error)),
      );
}
