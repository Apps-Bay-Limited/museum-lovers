import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/details_page.dart';
import 'package:museumLovers/screens/premium_page.dart';
import 'package:museumLovers/screens/slideshow_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

import 'artist_page.dart';

/// Opens the "Add to board" sheet for [art] (a Premium feature).
Future<void> showAddToBoardSheet(BuildContext context, Art art) async {
  final AppStore store = context.appStore;
  if (!await ensurePremium(context) || !context.mounted) {
    return;
  }
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext sheetContext) => _AddToBoardSheet(art: art, store: store),
  );
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

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
      appBar: AppBar(
        title: const Text('Collection'),
        actions: <Widget>[
          if (favorites.isNotEmpty)
            IconButton(
              tooltip: 'Play slideshow',
              icon: const Icon(Icons.slideshow_rounded),
              onPressed: () => Navigator.push<dynamic>(
                context,
                CupertinoPageRoute<dynamic>(builder: (BuildContext context) => SlideshowPage(arts: favorites)),
              ),
            ),
          const SizedBox(width: 4),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            _CountTab(label: 'Artworks', count: favorites.length),
            _CountTab(label: 'Artists', count: favoriteArtists.length),
            _CountTab(label: 'Boards', count: collections.length),
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

class _CountTab extends StatelessWidget {
  const _CountTab({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => Tab(
        height: 42,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label),
            if (count > 0) ...<Widget>[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: const ShapeDecoration(color: AppColors.surfaceHigh, shape: StadiumBorder()),
                child: Text('$count', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      );
}

enum _SortMode { recentlyAdded, titleAsc, artistAsc }

extension on _SortMode {
  String get label {
    switch (this) {
      case _SortMode.recentlyAdded:
        return 'Recent';
      case _SortMode.titleAsc:
        return 'Title A–Z';
      case _SortMode.artistAsc:
        return 'Artist A–Z';
    }
  }
}

class _ArtworksTab extends StatefulWidget {
  const _ArtworksTab({required this.favorites});

  final List<Art> favorites;

  @override
  State<_ArtworksTab> createState() => _ArtworksTabState();
}

class _ArtworksTabState extends State<_ArtworksTab> with AutomaticKeepAliveClientMixin<_ArtworksTab> {
  _SortMode _sortMode = _SortMode.recentlyAdded;
  String? _artistFilter;

  @override
  bool get wantKeepAlive => true;

  List<Art> get _visibleFavorites {
    List<Art> items = widget.favorites;
    if (_artistFilter != null) {
      items = items.where((Art art) => _artistKey(art) == _artistFilter!.toLowerCase()).toList();
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

  // The museum data spells some makers inconsistently ("anonymous" vs
  // "Anonymous"), so artist filters group case-insensitively.
  static String _artistKey(Art art) => art.principalOrFirstMaker.trim().toLowerCase();

  List<String> get _artists {
    final Map<String, int> counts = <String, int>{};
    final Map<String, String> labels = <String, String>{};
    for (final Art art in widget.favorites) {
      final String key = _artistKey(art);
      counts.update(key, (int n) => n + 1, ifAbsent: () => 1);
      final String name = art.principalOrFirstMaker.trim();
      labels.putIfAbsent(key, () => name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}');
    }
    // Most-saved artists first: they're the filters people actually want.
    final List<String> keys = counts.keys.toList()..sort((String a, String b) => counts[b]!.compareTo(counts[a]!));
    return <String>[for (final String key in keys) labels[key]!];
  }

  Future<void> _showSortMenu(BuildContext context) async {
    final _SortMode? selected = await showModalBottomSheet<_SortMode>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionHeader('Sort by', padding: EdgeInsets.fromLTRB(20, 0, 20, 8)),
            for (final _SortMode mode in _SortMode.values)
              ListTile(
                title: Text(mode.label),
                trailing: mode == _sortMode ? const Icon(Icons.check_rounded, color: AppColors.accent) : null,
                onTap: () => Navigator.pop(context, mode),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() => _sortMode = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.favorites.isEmpty) {
      return const EmptyState(
        icon: Icons.favorite_outline_rounded,
        title: 'No favorites yet',
        message: 'Tap the heart on any artwork to save it here.',
      );
    }

    final List<Art> items = _visibleFavorites;
    final List<String> artists = _artists;

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ChipRail(
              children: <Widget>[
                PillChip(
                  label: _sortMode.label,
                  icon: Icons.swap_vert_rounded,
                  onTap: () => _showSortMenu(context),
                ),
                if (artists.length > 1) ...<Widget>[
                  PillChip(
                    label: 'All',
                    selected: _artistFilter == null,
                    onTap: () => setState(() => _artistFilter = null),
                  ),
                  for (final String artist in artists)
                    PillChip(
                      label: artist,
                      selected: artist == _artistFilter,
                      onTap: () => setState(() => _artistFilter = artist == _artistFilter ? null : artist),
                    ),
                ],
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: kArtGridPadding.copyWith(top: 14),
          sliver: SliverGrid.builder(
            gridDelegate: kArtGridDelegate,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final Art art = items[index];
              return ArtGridItem(
                key: ValueKey<String>(art.id),
                art: art,
                onPressed: () => DetailsPage.go(context, art: art),
                onLongPress: () => showAddToBoardSheet(context, art),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              'Tip: long-press an artwork to add it to a board',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Add to board', style: displayStyle(20)),
            const SizedBox(height: 4),
            Text(
              widget.art.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            if (collections.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text('No boards yet — create your first one.', style: TextStyle(color: AppColors.textSecondary)),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.4),
                child: SurfaceCard(
                  padding: EdgeInsets.zero,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: collections.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(indent: 16, height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      final ArtCollection collection = collections[index];
                      return CheckboxListTile(
                        value: widget.store.isInCollection(collection.id, widget.art),
                        title: Text(collection.name),
                        subtitle: Text(_artworkCount(collection.items.length)),
                        onChanged: (_) => setState(() => widget.store.toggleInCollection(collection.id, widget.art)),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.tonalIcon(
                onPressed: _createBoard,
                icon: const Icon(Icons.add_rounded),
                label: const Text('New board'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _artworkCount(int count) => count == 1 ? '1 artwork' : '$count artworks';

Future<String?> _promptForName(BuildContext context, {required String title, String initialValue = ''}) {
  final TextEditingController controller = TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(hintText: 'e.g. Dutch landscapes'),
        onSubmitted: (String value) => Navigator.pop(context, value),
      ),
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
      ],
    ),
  ).whenComplete(controller.dispose);
}

class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab({required this.artists});

  final List<ArtMaker> artists;

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return const EmptyState(
        icon: Icons.person_outline_rounded,
        title: 'No favorite artists yet',
        message: 'Tap the heart on an artist page to follow them here.',
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: <Widget>[
        SurfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < artists.length; i++) ...<Widget>[
                if (i > 0) const Divider(),
                InkWell(
                  onTap: () => Navigator.push<dynamic>(
                    context,
                    CupertinoPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          ArtistPage(artistId: artists[i].id!, artistName: artists[i].name),
                    ),
                  ),
                  child: ArtMakerItem(key: ValueKey<String>(artists[i].id!), maker: artists[i]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _BoardsTab extends StatelessWidget {
  const _BoardsTab({required this.collections});

  final List<ArtCollection> collections;

  Future<void> _createBoard(BuildContext context) async {
    final AppStore store = context.appStore;
    if (!await ensurePremium(context) || !context.mounted) {
      return;
    }
    final String? name = await _promptForName(context, title: 'New board');
    if (name != null && name.trim().isNotEmpty) {
      store.createCollection(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = context.appStore.isPremium;
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Group artworks into themed boards — tap “Board” on any artwork.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
        ),
        SliverPadding(
          padding: kArtGridPadding.copyWith(top: 12),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.82,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: collections.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == collections.length) {
                return _NewBoardCard(locked: !isPremium, onTap: () => _createBoard(context));
              }
              return _BoardCard(collection: collections[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _BoardCard extends StatelessWidget {
  const _BoardCard({required this.collection});

  final ArtCollection collection;

  Future<void> _showActions(BuildContext context) async {
    final AppStore store = context.appStore;
    final String? action = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Rename'),
              onTap: () => Navigator.pop(context, 'rename'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: Color(0xffff8a80)),
              title: const Text('Delete board', style: TextStyle(color: Color(0xffff8a80))),
              onTap: () => Navigator.pop(context, 'delete'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (!context.mounted) {
      return;
    }
    if (action == 'rename') {
      final String? name = await _promptForName(context, title: 'Rename board', initialValue: collection.name);
      if (name != null) {
        store.renameCollection(collection.id, name);
      }
    } else if (action == 'delete') {
      final bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Delete “${collection.name}”?'),
          content: const Text('The artworks stay in your favorites.'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
          ],
        ),
      );
      if (confirmed == true) {
        store.deleteCollection(collection.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Art> covers = collection.items.where((Art art) => art.webImage?.url != null).take(4).toList();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.push<dynamic>(
        context,
        CupertinoPageRoute<dynamic>(builder: (BuildContext context) => _BoardDetailPage(collectionId: collection.id)),
      ),
      onLongPress: () => _showActions(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ColoredBox(
                color: AppColors.surface,
                child: covers.isEmpty
                    ? const Center(child: Icon(Icons.dashboard_outlined, color: AppColors.textTertiary, size: 32))
                    : _CoverMosaic(arts: covers),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      collection.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      _artworkCount(collection.items.length),
                      style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              SizedBox.square(
                dimension: 32,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  tooltip: 'Board options',
                  icon: const Icon(Icons.more_horiz_rounded, color: AppColors.textSecondary),
                  onPressed: () => _showActions(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// One large cover plus up to three small ones, like a photo-album stack.
class _CoverMosaic extends StatelessWidget {
  const _CoverMosaic({required this.arts});

  final List<Art> arts;

  Widget _image(Art art) => CachedImage(url: artImageUrl(art.webImage!.url!, 400), memCacheWidth: 400);

  @override
  Widget build(BuildContext context) {
    if (arts.length < 3) {
      return SizedBox.expand(child: _image(arts.first));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex: 2, child: _image(arts[0])),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 1; i < arts.length; i++) ...<Widget>[
                if (i > 1) const SizedBox(height: 2),
                Expanded(child: _image(arts[i])),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NewBoardCard extends StatelessWidget {
  const _NewBoardCard({required this.locked, required this.onTap});

  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.hairline, width: 1.5),
                ),
                child: Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(locked ? Icons.lock_outline_rounded : Icons.add_rounded, color: AppColors.accent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('New board', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(
              locked ? 'Premium' : 'Start a collection',
              style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
          ],
        ),
      );
}

class _BoardDetailPage extends StatelessWidget {
  const _BoardDetailPage({required this.collectionId});

  final String collectionId;

  void _remove(BuildContext context, AppStore store, Art art) {
    store.toggleInCollection(collectionId, art);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Removed from board'),
          action: SnackBarAction(label: 'Undo', onPressed: () => store.toggleInCollection(collectionId, art)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final ArtCollection? collection = store.collections.where((ArtCollection c) => c.id == collectionId).firstOrNull;
    if (collection == null) {
      return const Scaffold(body: SizedBox.shrink());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
        actions: <Widget>[
          if (collection.items.isNotEmpty)
            IconButton(
              tooltip: 'Play slideshow',
              icon: const Icon(Icons.slideshow_rounded),
              onPressed: () => Navigator.push<dynamic>(
                context,
                CupertinoPageRoute<dynamic>(builder: (BuildContext context) => SlideshowPage(arts: collection.items)),
              ),
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: collection.items.isEmpty
          ? const EmptyState(
              icon: Icons.dashboard_outlined,
              title: 'This board is empty',
              message: 'Open any artwork and tap “Board” to add it here.',
            )
          : GridView.builder(
              padding: kArtGridPadding,
              gridDelegate: kArtGridDelegate,
              itemCount: collection.items.length,
              itemBuilder: (BuildContext context, int index) {
                final Art art = collection.items[index];
                return ArtGridItem(
                  key: ValueKey<String>(art.id),
                  art: art,
                  onPressed: () => DetailsPage.go(context, art: art),
                  onLongPress: () => _remove(context, store, art),
                );
              },
            ),
    );
  }
}
