import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/store/app_store.dart';

/// Heart toggle that reflects and updates the favorite state of [art].
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.art,
    this.iconSize = 18,
    this.backgroundColor = Colors.black38,
  }) : super(key: key);

  final Art art;
  final double iconSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final bool favorite = store.isFavorite(art);
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.selectionClick();
          store.toggleFavorite(art);
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: favorite ? Colors.redAccent : Colors.white,
            semanticLabel: favorite ? 'Remove from favorites' : 'Add to favorites',
          ),
        ),
      ),
    );
  }
}
