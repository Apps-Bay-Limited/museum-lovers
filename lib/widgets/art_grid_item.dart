import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/widgets.dart';

class ArtGridItem extends StatelessWidget {
  const ArtGridItem({Key? key, required this.art, required this.onPressed}) : super(key: key);

  final Art art;
  final VoidCallback onPressed;

  @visibleForTesting
  static const Key inkWellBoxKey = Key('ink-well-box');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          key: inkWellBoxKey,
          onTap: onPressed,
          child: Stack(
            children: <Widget>[
              if (art.webImage?.url != null)
                Positioned.fill(
                  child: CachedImage(
                    url: art.webImage!.url!,
                    builder: (ImageProvider<Object> provider) =>
                        Ink.image(image: provider, fit: BoxFit.cover),
                  ),
                ),
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              //     margin: const EdgeInsets.fromLTRB(4, 4, 16, 0),
              //     decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(16)),
              //     child: Row(
              //       children: <Widget>[
              //         Icon(Icons.format_paint, size: 14, color: theme.colorScheme.onBackground),
              //         AppSpacing.h4,
              //         Text(
              //           art.principalOrFirstMaker,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           style: textTheme.caption?.copyWith(color: theme.colorScheme.onBackground),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Positioned.fill(
                top: null,
                child: Container(
                  color: Colors.black38,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Text(
                    art.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1?.copyWith(color: theme.colorScheme.onBackground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
