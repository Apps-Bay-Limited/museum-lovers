import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/search_detail_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/theme.dart';
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

void _openSearch(BuildContext context, String term) => Navigator.push<dynamic>(
      context,
      CupertinoPageRoute<dynamic>(builder: (_) => SearchDetailPage(searchTerm: term)),
    );

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

    final AppStore store = AppStoreProvider.read(context);
    final AppOpenAdManager appOpenAdManager = AppOpenAdManager();
    WidgetsBinding.instance.addObserver(AppLifecycleReactor(
      appOpenAdManager: appOpenAdManager,
      isAdFree: () => store.isAdFree,
    ));
    if (!store.isPremium) {
      appOpenAdManager.loadAd();
      RewardedAdManager.preload();
    }
  }

  @override
  void dispose() {
    controller.dispose();
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

  void _onSearch(String value) {
    final String term = value.trim();
    if (term.isEmpty) {
      return;
    }
    AppStoreProvider.read(context).addRecentSearch(term);
    _openSearch(context, term);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                toolbarHeight: 60,
                titleSpacing: 16,
                title: _SearchField(controller: _inputController, onSubmitted: _onSearch),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 16),
                    child: _QuizButton(
                      onTap: () => Navigator.push<dynamic>(
                        context,
                        CupertinoPageRoute<dynamic>(builder: (_) => const QuizPage()),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(child: _DiscoverySection(arts: _masterpieces)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _CategoryBarDelegate(selected: _selectedCategory, onSelected: _onCategorySelected),
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == LoadingStatus.initial) {
                    if (controller.isLoading) {
                      return const SliverToBoxAdapter(child: SizedBox(height: 240, child: LoadingSpinner()));
                    }
                    if (controller.hasError) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 240,
                          child: Center(
                            key: HomePage.errorBoxKey,
                            child: ErrorDisplayView(message: controller.error!.message, onRetry: _onRetry),
                          ),
                        ),
                      );
                    }
                  }

                  final List<Art> items = controller.data;
                  if (items.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: EmptyState(
                        key: HomePage.emptyStateKey,
                        icon: Icons.image_search,
                        title: 'No artworks found',
                        message: 'Try another category or search for an artist.',
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: kArtGridPadding,
                    sliver: SliverGrid(
                      gridDelegate: kArtGridDelegate,
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
                  child: const SizedBox(height: 32),
                  builder: (BuildContext context, Widget? child) {
                    if (_loadingStatus == LoadingStatus.initial || !(controller.isLoading || controller.hasError)) {
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
                    return SafeArea(top: false, child: SizedBox(height: kToolbarHeight, child: child));
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
        notification.metrics.pixels >= notification.metrics.maxScrollExtent - loadMoreThreshold) {
      _onLoadMoreWhenIdle();
    }
    return false;
  }
}

enum LoadingStatus { idle, initial, loading }

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 42,
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: onSubmitted,
          cursorColor: AppColors.accent,
          style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceHigh,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 11),
            hintText: 'Search art & artists',
            hintStyle: const TextStyle(fontSize: 15, color: AppColors.textTertiary),
            prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textTertiary),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (BuildContext context, TextEditingValue value, _) => value.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.cancel, size: 18, color: AppColors.textTertiary),
                      onPressed: controller.clear,
                    ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      );
}

class _QuizButton extends StatelessWidget {
  const _QuizButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: 'Art quiz',
        child: Material(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: const SizedBox(
              height: 42,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.extension_outlined, size: 18, color: AppColors.accent),
                    SizedBox(width: 6),
                    Text('Quiz', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _CategoryBarDelegate extends SliverPersistentHeaderDelegate {
  _CategoryBarDelegate({required this.selected, required this.onSelected});

  final _BrowseCategory selected;
  final ValueChanged<_BrowseCategory> onSelected;

  static const double _height = 50;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => ColoredBox(
        color: AppColors.background,
        child: Center(
          child: ChipRail(
            children: <Widget>[
              for (final _BrowseCategory category in _categories)
                PillChip(
                  label: category.label,
                  selected: identical(category, selected),
                  onTap: () => onSelected(category),
                ),
            ],
          ),
        ),
      );

  @override
  bool shouldRebuild(_CategoryBarDelegate oldDelegate) => !identical(oldDelegate.selected, selected);
}

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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: artworkOfDay == null
              ? Container(
                  height: _ArtworkOfDayCard.height,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
                )
              : _ArtworkOfDayCard(art: artworkOfDay),
        ),
        const SectionHeader('Featured artists'),
        ChipRail(
          children: <Widget>[
            for (final String term in curatedTerms)
              PillChip(label: term, leading: InitialsAvatar(term), onTap: () => _openSearch(context, term)),
          ],
        ),
        if (recentlyViewed.isNotEmpty) ...<Widget>[
          const SectionHeader('Recently viewed'),
          ArtRail(arts: recentlyViewed, onTap: (Art art) => DetailsPage.go(context, art: art)),
        ],
        if (recents.isNotEmpty) ...<Widget>[
          SectionHeader('Recent searches', actionLabel: 'Clear', onAction: store.clearRecentSearches),
          ChipRail(
            children: <Widget>[
              for (final String term in recents)
                PillChip(label: term, icon: Icons.history, onTap: () => _openSearch(context, term)),
            ],
          ),
        ],
        const SectionHeader('Browse the collection', padding: EdgeInsets.fromLTRB(16, 24, 8, 0)),
      ],
    );
  }
}

class _ArtworkOfDayCard extends StatelessWidget {
  const _ArtworkOfDayCard({Key? key, required this.art}) : super(key: key);

  static const double height = 200;

  final Art art;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: AppColors.surface,
          child: InkWell(
            onTap: () => DetailsPage.go(context, art: art),
            child: SizedBox(
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (art.webImage?.url != null) CachedImage(url: artImageUrl(art.webImage!.url!, kGridImageSize)),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Colors.transparent, Color(0xe6000000)],
                        stops: <double>[0.35, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Icon(Icons.auto_awesome, size: 12, color: AppColors.accent),
                            SizedBox(width: 5),
                            Text(
                              'ARTWORK OF THE DAY',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(art.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: displayStyle(20)),
                        const SizedBox(height: 3),
                        Text(
                          art.principalOrFirstMaker,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
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
