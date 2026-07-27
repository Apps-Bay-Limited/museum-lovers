import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/search_detail_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

import 'data_controller.dart';
import 'details_page.dart';
import 'quiz_page.dart';

/// A browsable Explore category: either a `type=` filter or the curated
/// Top 1000 masterpieces set.
class _BrowseCategory {
  const _BrowseCategory({required this.label, this.type, this.masterpieces = false});

  final String label;
  final String? type;
  final bool masterpieces;
}

const List<_BrowseCategory> _categories = <_BrowseCategory>[
  _BrowseCategory(label: 'Paintings', type: 'painting'),
  _BrowseCategory(label: 'Top 1000', masterpieces: true),
  _BrowseCategory(label: 'Drawings', type: 'drawing'),
  _BrowseCategory(label: 'Sculptures', type: 'sculpture'),
  _BrowseCategory(label: 'Photographs', type: 'photograph'),
  _BrowseCategory(label: 'Furniture', type: 'furniture'),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @visibleForTesting
  static const Key overscrollBoxKey = Key('overscroll-box');
  @visibleForTesting
  static const Key errorBoxKey = Key('error-box');
  @visibleForTesting
  static const Key emptyStateKey = Key('empty-state');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _BrowseCategory _selectedCategory = _categories.first;

  late final PagedDataController controller = PagedDataController(
    ({required int page}) => context.repository.fetchAll(
      page: page,
      type: _selectedCategory.type ?? 'painting',
      masterpieces: _selectedCategory.masterpieces,
    ),
  );
  final TextEditingController _inputController = TextEditingController();

  final ValueNotifier<bool> singleColumn = ValueNotifier<bool>(false);

  late final Listenable combinedViewModel =
      Listenable.merge(<Listenable>[controller, singleColumn]);

  static const double loadMoreThreshold = 300;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  /// Sourced independently from whichever category is currently browsed, so
  /// Artwork of the Day always draws from the museum's curated highlights.
  List<Art> _masterpieces = <Art>[];

  @override
  void initState() {
    controller.fetch().then(_onFinishedRequest);
    context.repository.fetchAll(page: 1, masterpieces: true).then((List<Art> arts) {
      if (mounted) {
        setState(() => _masterpieces = arts);
      }
    });
    super.initState();

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance.addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager));
  }

  @override
  void dispose() {
    controller.dispose();
    singleColumn.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onCategorySelected(_BrowseCategory category) {
    if (identical(category, _selectedCategory)) {
      return;
    }
    setState(() {
      _selectedCategory = category;
      _loadingStatus = LoadingStatus.initial;
    });
    controller.fetch().then(_onFinishedRequest);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff141213),
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: <Widget>[
              SliverAppBar(
                title: Container(
                    // padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      controller: _inputController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (String value) {
                        if (value.isNotEmpty == true) {
                          AppStoreProvider.read(context).addRecentSearch(value);
                          Navigator.push<dynamic>(
                            context,
                            CupertinoPageRoute<dynamic>(
                              builder: (_) => SearchDetailPage(
                                searchTerm: value,
                              ),
                            ),
                          );
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _inputController,
                            builder: (BuildContext context, TextEditingValue value, _) {
                              if (value.text.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return IconButton(
                                tooltip: 'Clear',
                                icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                                onPressed: _inputController.clear,
                              );
                            },
                          ),
                          hintText: 'Search artworks or artists',
                          hintStyle: const TextStyle(color: Colors.grey)),
                    )),
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    tooltip: 'Art quiz',
                    icon: const Icon(Icons.quiz_outlined),
                    onPressed: () => Navigator.push<dynamic>(
                      context,
                      CupertinoPageRoute<dynamic>(builder: (_) => const QuizPage()),
                    ),
                  ),
                ],
                backgroundColor: Color(0xff141213),
              ),
              SliverToBoxAdapter(
                child: _DiscoverySection(arts: _masterpieces),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final _BrowseCategory category = _categories[index];
                      return _CategoryChip(
                        label: category.label,
                        selected: identical(category, _selectedCategory),
                        onTap: () => _onCategorySelected(category),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              AnimatedBuilder(
                animation: combinedViewModel,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == LoadingStatus.initial) {
                    if (controller.isLoading) {
                      return const SliverFillRemaining(child: LoadingSpinner());
                    }
                    if (controller.hasError) {
                      return SliverFillRemaining(
                        child: Center(
                          key: HomePage.errorBoxKey,
                          child: ErrorDisplayView(
                              message: controller.error!.message, onRetry: _onRetry),
                        ),
                      );
                    }
                  }

                  final List<Art> items = controller.data;
                  if (items.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                          key: HomePage.emptyStateKey,
                          child: Text('Could not find any art works? :(')),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: singleColumn.value ? 1 : 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Art art = items[index];
                          return ArtGridItem(
                            key: ValueKey<String>(art.id),
                            art: art,
                            onPressed: () => DetailsPage.go(context, art: art),
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                key: HomePage.overscrollBoxKey,
                child: AnimatedBuilder(
                  animation: controller,
                  child: Container(color: const Color(0xff141213), height: 32),
                  builder: (BuildContext context, Widget? child) {
                    if (_loadingStatus == LoadingStatus.initial ||
                        !(controller.isLoading || controller.hasError)) {
                      return child!;
                    }

                    child = controller.isLoading
                        ? const LoadingSpinner()
                        : controller.hasError
                            ? Padding(
                                key: HomePage.errorBoxKey,
                                padding: const EdgeInsets.all(8),
                                child: ErrorDisplayView(
                                  message: controller.error!.message,
                                  onRetry: _onRetry,
                                  direction: Axis.horizontal,
                                ),
                              )
                            : null;
                    return SafeArea(
                        top: false,
                        child: Container(
                            color: const Color(0xff141213),
                            height: kToolbarHeight,
                            child: Material(color: Color(0xff141213), child: child)));
                  },
                ),
              ),
            ],
          ),
        ),
      );

  void _onRetry() => controller.retry().then(_onFinishedRequest);

  void _onLoadMore() => controller.next().then((_) => _loadingStatus = LoadingStatus.idle);

  void _onFinishedRequest(void _) {
    if (!controller.hasError) {
      _loadingStatus = LoadingStatus.idle;
    }
  }

  void _onLoadMoreWhenIdle() {
    if (_loadingStatus == LoadingStatus.idle) {
      _loadingStatus = LoadingStatus.loading;
      _onLoadMore();
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (Axis.vertical == notification.metrics.axis &&
        notification is ScrollUpdateNotification &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - loadMoreThreshold) {
      _onLoadMoreWhenIdle();
    }
    return false;
  }
}

enum LoadingStatus { idle, initial, loading }

class _DiscoverySection extends StatelessWidget {
  const _DiscoverySection({Key? key, required this.arts}) : super(key: key);

  final List<Art> arts;

  static const List<String> curatedTerms = <String>[
    'Rembrandt van Rijn',
    'Johannes Vermeer',
    'Vincent van Gogh',
    'Frans Hals',
    'Jan Steen',
    'Rachel Ruysch',
    'Judith Leyster',
    'Gerard van Honthorst',
  ];

  static int get _dayOfYear {
    final DateTime now = DateTime.now();
    return now.difference(DateTime(now.year)).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    final List<String> recents = store.recentSearches;
    final List<Art> recentlyViewed = store.recentlyViewed;
    final Art? artworkOfDay = arts.isEmpty ? null : arts[_dayOfYear % arts.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (artworkOfDay != null) _ArtworkOfDayCard(art: artworkOfDay),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: curatedTerms.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
            itemBuilder: (BuildContext context, int index) => _SearchChip(label: curatedTerms[index]),
          ),
        ),
        if (recentlyViewed.isNotEmpty) ...<Widget>[
          const _SectionLabel('Recently viewed'),
          _RecentlyViewedRow(arts: recentlyViewed),
        ],
        if (recents.isNotEmpty) ...<Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
            child: Row(
              children: <Widget>[
                Text('Recent searches', style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                TextButton(
                  onPressed: store.clearRecentSearches,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: recents.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
              itemBuilder: (BuildContext context, int index) =>
                  _SearchChip(label: recents[index], icon: Icons.history),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall),
      );
}

class _ArtworkOfDayCard extends StatelessWidget {
  const _ArtworkOfDayCard({Key? key, required this.art}) : super(key: key);

  final Art art;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => DetailsPage.go(context, art: art),
          child: SizedBox(
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (art.webImage?.url != null)
                  CachedImage(url: artImageUrl(art.webImage!.url!, kGridImageSize)),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, Colors.black87],
                      stops: <double>[0.5, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xffD2FCAC),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'ARTWORK OF THE DAY',
                          style: TextStyle(
                            color: Color(0xff141213),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        art.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        art.principalOrFirstMaker,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
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

class _RecentlyViewedRow extends StatelessWidget {
  const _RecentlyViewedRow({Key? key, required this.arts}) : super(key: key);

  final List<Art> arts;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: arts.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final Art art = arts[index];
          return SizedBox(
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => DetailsPage.go(context, art: art),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (art.webImage?.url != null)
                      CachedImage(url: artImageUrl(art.webImage!.url!, kGridImageSize)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black38,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        child: Text(
                          art.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({Key? key, required this.label, required this.selected, required this.onTap})
      : super(key: key);

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: selected ? const Color(0xffD2FCAC) : Colors.white10,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? const Color(0xff141213) : Colors.white70,
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
}

class _SearchChip extends StatelessWidget {
  const _SearchChip({Key? key, required this.label, this.icon}) : super(key: key);

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push<dynamic>(
            context,
            CupertinoPageRoute<dynamic>(
              builder: (_) => SearchDetailPage(searchTerm: label),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 14, color: Colors.white54),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: const TextStyle(color: Color(0xffD2FCAC), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
