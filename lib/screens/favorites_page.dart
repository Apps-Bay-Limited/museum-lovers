import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/constants.dart';
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
  late final TabController _tabController = TabController(length: 3, vsync: this);

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
    final List<ArtCollection> collections = store.collections;

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
            Tab(text: 'Boards (${collections.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _ArtworksTab(favorites: favorites),
          _ArtistsTab(artists: favoriteArtists),
          _BoardsTab(collections: collections),
        ],
      ),
    );
  }
}

enum _SortMode { recentlyAdded, titleAsc, artistAsc }

extension on _SortMode {
  String get label {
    switch (this) {
      case _SortMode.recentlyAdded:
        return 'Recently added';
      case _SortMode.titleAsc:
        return 'Title A–Z';
      case _SortMode.artistAsc:
        return 'Artist A–Z';
    }
  }
}

class _ArtworksTab extends StatefulWidget {
  const _ArtworksTab({Key? key, required this.favorites}) : super(key: key);

  final List<Art> favorites;

  @override
  State<_ArtworksTab> createState() => _ArtworksTabState();
}

class _ArtworksTabState extends State<_ArtworksTab> {
  _SortMode _sortMode = _SortMode.recentlyAdded;
  String? _artistFilter;

  List<Art> get _visibleFavorites {
    List<Art> items = widget.favorites;
    if (_artistFilter != null) {
      items = items.where((Art art) => art.principalOrFirstMaker == _artistFilter).toList();
    }
    switch (_sortMode) {
      case _SortMode.recentlyAdded:
        return items;
      case _SortMode.titleAsc:
        return <Art>[...items]..sort((Art a, Art b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      case _SortMode.artistAsc:
        return <Art>[...items]
          ..sort((Art a, Art b) =>
              a.principalOrFirstMaker.toLowerCase().compareTo(b.principalOrFirstMaker.toLowerCase()));
    }
  }

  List<String> get _artists {
    final List<String> artists = widget.favorites.map((Art art) => art.principalOrFirstMaker).toSet().toList()
      ..sort((String a, String b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return artists;
  }

  Future<void> _showSortMenu(BuildContext context) async {
    final _SortMode? selected = await showModalBottomSheet<_SortMode>(
      context: context,
      backgroundColor: const Color(0xff1d1b1c),
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final _SortMode mode in _SortMode.values)
              ListTile(
                title: Text(mode.label),
                trailing: mode == _sortMode ? const Icon(Icons.check, color: Color(0xffD2FCAC)) : null,
                onTap: () => Navigator.pop(context, mode),
              ),
          ],
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() => _sortMode = selected);
    }
  }

  Future<void> _showAddToBoardSheet(BuildContext context, Art art) async {
    final AppStore store = context.appStore;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xff1d1b1c),
      isScrollControlled: true,
      builder: (BuildContext sheetContext) => _AddToBoardSheet(art: art, store: store),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favorites.isEmpty) {
      return const _EmptyState(
        icon: Icons.favorite_outline,
        title: 'No favorites yet',
        message: 'Tap the heart on any artwork to save it here',
      );
    }

    final List<Art> items = _visibleFavorites;
    final List<String> artists = _artists;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () => _showSortMenu(context),
                icon: const Icon(Icons.sort, size: 18),
                label: Text(_sortMode.label),
              ),
              const Spacer(),
              Text('${items.length} of ${widget.favorites.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54)),
            ],
          ),
        ),
        if (artists.length > 1)
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: artists.length + 1,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
              itemBuilder: (BuildContext context, int index) {
                final String? artist = index == 0 ? null : artists[index - 1];
                final bool selected = artist == _artistFilter;
                return Material(
                  color: selected ? const Color(0xffD2FCAC) : Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => setState(() => _artistFilter = artist),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text(
                        artist ?? 'All artists',
                        style: TextStyle(
                          color: selected ? const Color(0xff141213) : Colors.white70,
                          fontSize: 13,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final Art art = items[index];
              return ArtGridItem(
                key: ValueKey<String>(art.id),
                art: art,
                onPressed: () => DetailsPage.go(context, art: art),
                onLongPress: () => _showAddToBoardSheet(context, art),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AddToBoardSheet extends StatefulWidget {
  const _AddToBoardSheet({required this.art, required this.store});

  final Art art;
  final AppStore store;

  @override
  State<_AddToBoardSheet> createState() => _AddToBoardSheetState();
}

class _AddToBoardSheetState extends State<_AddToBoardSheet> {
  Future<void> _createBoard() async {
    final String? name = await _promptForName(context, title: 'New board');
    if (name == null || name.trim().isEmpty) {
      return;
    }
    final ArtCollection collection = widget.store.createCollection(name);
    widget.store.toggleInCollection(collection.id, widget.art);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ArtCollection> collections = widget.store.collections;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Add to board', style: Theme.of(context).textTheme.titleMedium),
            AppSpacing.v12,
            if (collections.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('No boards yet — create one below.', style: TextStyle(color: Colors.white60)),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    for (final ArtCollection collection in collections)
                      CheckboxListTile(
                        value: widget.store.isInCollection(collection.id, widget.art),
                        title: Text(collection.name),
                        subtitle: Text('${collection.items.length} artworks'),
                        checkColor: const Color(0xff141213),
                        activeColor: const Color(0xffD2FCAC),
                        onChanged: (_) => setState(() => widget.store.toggleInCollection(collection.id, widget.art)),
                      ),
                  ],
                ),
              ),
            AppSpacing.v8,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _createBoard,
                icon: const Icon(Icons.add),
                label: const Text('New board'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _promptForName(BuildContext context, {required String title, String initialValue = ''}) {
  final TextEditingController controller = TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: const Color(0xff1d1b1c),
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Board name'),
        onSubmitted: (String value) => Navigator.pop(context, value),
      ),
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
      ],
    ),
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

class _BoardsTab extends StatelessWidget {
  const _BoardsTab({Key? key, required this.collections}) : super(key: key);

  final List<ArtCollection> collections;

  Future<void> _createBoard(BuildContext context) async {
    final AppStore store = context.appStore;
    final String? name = await _promptForName(context, title: 'New board');
    if (name != null && name.trim().isNotEmpty) {
      store.createCollection(name);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Group your favorites into themed boards.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _createBoard(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New'),
                ),
              ],
            ),
          ),
          Expanded(
            child: collections.isEmpty
                ? const _EmptyState(
                    icon: Icons.dashboard_outlined,
                    title: 'No boards yet',
                    message: 'Long-press any favorite artwork to add it to a new board',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: collections.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final ArtCollection collection = collections[index];
                      return Material(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          leading: const Icon(Icons.dashboard_outlined, color: Color(0xffD2FCAC)),
                          title: Text(collection.name),
                          subtitle: Text('${collection.items.length} artworks'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.white54),
                            tooltip: 'Delete board',
                            onPressed: () => context.appStore.deleteCollection(collection.id),
                          ),
                          onTap: () => Navigator.push<dynamic>(
                            context,
                            CupertinoPageRoute<dynamic>(
                              builder: (BuildContext context) => _BoardDetailPage(collectionId: collection.id),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
}

class _BoardDetailPage extends StatelessWidget {
  const _BoardDetailPage({required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final ArtCollection? collection = store.collections.where((ArtCollection c) => c.id == collectionId).firstOrNull;
    if (collection == null) {
      return const Scaffold(backgroundColor: Color(0xff141213), body: SizedBox.shrink());
    }
    return Scaffold(
      backgroundColor: const Color(0xff141213),
      appBar: AppBar(
        backgroundColor: const Color(0xff141213),
        title: Text(collection.name),
        actions: <Widget>[
          if (collection.items.isNotEmpty)
            IconButton(
              tooltip: 'Slideshow',
              icon: const Icon(Icons.slideshow),
              onPressed: () => Navigator.push<dynamic>(
                context,
                CupertinoPageRoute<dynamic>(
                  builder: (BuildContext context) => SlideshowPage(arts: collection.items),
                ),
              ),
            ),
        ],
      ),
      body: collection.items.isEmpty
          ? const _EmptyState(
              icon: Icons.dashboard_outlined,
              title: 'This board is empty',
              message: 'Long-press a favorite artwork and add it here',
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: collection.items.length,
              itemBuilder: (BuildContext context, int index) {
                final Art art = collection.items[index];
                return ArtGridItem(
                  key: ValueKey<String>(art.id),
                  art: art,
                  onPressed: () => DetailsPage.go(context, art: art),
                  onLongPress: () {
                    store.toggleInCollection(collectionId, art);
                  },
                );
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({Key? key, required this.icon, required this.title, required this.message})
      : super(key: key);

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 64, color: Colors.white24),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
              ),
            ],
          ),
        ),
      );
}
