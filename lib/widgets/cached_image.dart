import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_spinner.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({Key? key, required this.url, this.builder, this.fit = BoxFit.cover}) : super(key: key);

  final String url;
  final Widget Function(ImageProvider<Object>)? builder;
  final BoxFit fit;

  static const Key loadingKey = Key('loading');

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        key: Key(url),
        imageUrl: url,
        fit: fit,
        imageBuilder: builder != null ? (_, ImageProvider<Object> imageProvider) => builder!(imageProvider) : null,
        placeholder: (_, __) => const LoadingSpinner(key: loadingKey),
        errorWidget: (_, __, Object? ___) => const Center(child: Icon(Icons.error)),
      );
}
