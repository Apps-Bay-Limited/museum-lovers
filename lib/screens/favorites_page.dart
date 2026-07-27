import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/details_page.dart';
import 'package:museumLovers/screens/slideshow_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/widgets.dart';

import 'artist_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final List<Art> favorites = store.favorites.reversed.toList();
    final List<ArtMaker> favoriteArtists = store.favoriteArtists.reversed.toList();

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
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            const Tab(text: 'Artworks'),
            Tab(text: 'Artists (${favoriteArtists.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _ArtworksTab(favorites: favorites),
          _ArtistsTab(artists: favoriteArtists),
        ],
      ),
    );
  }
}

class _ArtworksTab extends StatelessWidget {
  const _ArtworksTab({Key? key, required this.favorites}) : super(key: key);

  final List<Art> favorites;

  @override
  Widget build(BuildContext context) => favorites.isEmpty
      ? const _EmptyState(
          icon: Icons.favorite_outline,
          title: 'No favorites yet',
          message: 'Tap the heart on any artwork to save it here',
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
        );
}

class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab({Key? key, required this.artists}) : super(key: key);

  final List<ArtMaker> artists;

  @override
  Widget build(BuildContext context) => artists.isEmpty
      ? const _EmptyState(
          icon: Icons.person_outline,
          title: 'No favorite artists yet',
          message: 'Tap the heart on an artist page to save it here',
        )
      : ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          itemCount: artists.length,
          itemBuilder: (BuildContext context, int index) {
            final ArtMaker artist = artists[index];
            return InkWell(
              onTap: () => Navigator.push<dynamic>(
                context,
                CupertinoPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      ArtistPage(artistId: artist.id!, artistName: artist.name),
                ),
              ),
              child: ArtMakerItem(key: ValueKey<String>(artist.id!), maker: artist),
            );
          },
        );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({Key? key, required this.icon, required this.title, required this.message})
      : super(key: key);

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 64, color: Colors.white24),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      );
}
