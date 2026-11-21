import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

class ArtGridItem extends StatelessWidget {
  const ArtGridItem({Key? key, required this.art, required this.onPressed, this.onLongPress}) : super(key: key);

  final Art art;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  @visibleForTesting
  static const Key inkWellBoxKey = Key('ink-well-box');

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: AppColors.surface,
          child: InkWell(
            key: inkWellBoxKey,
            onTap: onPressed,
            onLongPress: onLongPress,
            child: Stack(
              children: <Widget>[
                if (art.webImage?.url != null)
                  Positioned.fill(
                    child: Hero(
                      tag: art.webImage!.url!,
                      // A local Material is required here (rather than relying on
                      // the ancestor above) because Hero flights temporarily
                      // reparent this child into the Navigator's Overlay, which
                      // has no Material ancestor of its own.
                      child: Material(
                        type: MaterialType.transparency,
                        child: CachedImage(
                          url: artImageUrl(art.webImage!.url!, kGridImageSize),
                          builder: (ImageProvider<Object> provider) => Ink.image(image: provider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                const Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.transparent, Color(0xd9000000)],
                          stops: <double>[0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        art.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, height: 1.2),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        art.principalOrFirstMaker,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Positioned(top: 8, right: 8, child: FavoriteButton(art: art)),
              ],
            ),
          ),
        ),
      );
}
