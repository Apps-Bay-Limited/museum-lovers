import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/store/app_store.dart';

/// Heart toggle that reflects and updates the favorite state of [artist].
/// Hidden when [artist] has no resolved Person id, since there's nothing
/// stable to favorite by.
class FavoriteArtistButton extends StatelessWidget {
  const FavoriteArtistButton({
    Key? key,
    required this.artist,
    this.iconSize = 18,
    this.backgroundColor = Colors.black38,
  }) : super(key: key);

  final ArtMaker artist;
  final double iconSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (artist.id == null) {
      return const SizedBox.shrink();
    }
    final AppStore store = context.appStore;
    final bool favorite = store.isFavoriteArtist(artist);
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.selectionClick();
          store.toggleFavoriteArtist(artist);
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: favorite ? Colors.redAccent : Colors.white,
            semanticLabel: favorite ? 'Remove artist from favorites' : 'Add artist to favorites',
          ),
        ),
      ),
    );
  }
}
