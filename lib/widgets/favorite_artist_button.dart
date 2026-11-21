import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/theme.dart';

/// "Follow" pill that reflects and updates the favorite state of [artist].
/// Hidden when [artist] has no resolved Person id, since there's nothing
/// stable to favorite by.
class FavoriteArtistButton extends StatelessWidget {
  const FavoriteArtistButton({super.key, required this.artist});

  final ArtMaker artist;

  @override
  Widget build(BuildContext context) {
    if (artist.id == null) {
      return const SizedBox.shrink();
    }
    final AppStore store = context.appStore;
    final bool favorite = store.isFavoriteArtist(artist);
    return Semantics(
      button: true,
      label: favorite ? 'Unfollow artist' : 'Follow artist',
      child: Material(
        color: favorite ? AppColors.surfaceHigh : AppColors.accent,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            store.toggleFavoriteArtist(artist);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  favorite ? Icons.check_rounded : Icons.add_rounded,
                  size: 16,
                  color: favorite ? AppColors.textPrimary : AppColors.onAccent,
                ),
                const SizedBox(width: 4),
                Text(
                  favorite ? 'Following' : 'Follow',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: favorite ? AppColors.textPrimary : AppColors.onAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
