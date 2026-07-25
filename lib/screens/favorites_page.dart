import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/details_page.dart';
import 'package:museumLovers/screens/slideshow_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final List<Art> favorites = store.favorites.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xff141213),
      appBar: AppBar(
        backgroundColor: const Color(0xff141213),
        title: const Text('My Collection'),
        actions: <Widget>[
          if (favorites.isNotEmpty)
            IconButton(
              tooltip: 'Slideshow',
              icon: const Icon(Icons.slideshow),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  CupertinoPageRoute<dynamic>(
                    builder: (BuildContext context) => SlideshowPage(arts: favorites),
                  ),
                );
              },
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.favorite_outline, size: 64, color: Colors.white24),
                  const SizedBox(height: 16),
                  Text('No favorites yet', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart on any artwork to save it here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final Art art = favorites[index];
                return ArtGridItem(
                  key: ValueKey<String>(art.id),
                  art: art,
                  onPressed: () => DetailsPage.go(context, art: art),
                );
              },
            ),
    );
  }
}
