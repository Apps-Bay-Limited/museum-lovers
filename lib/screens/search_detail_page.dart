import 'package:flutter/material.dart';
import 'package:museumLovers/domain/models.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/widgets/art_grid_item.dart';
import 'package:museumLovers/widgets/error_display_view.dart';
import 'package:museumLovers/widgets/loading_spinner.dart';

import 'data_controller.dart';
import 'details_page.dart';

/// A type facet shown as a filter chip in search results. [type] is the
/// repository's `type=` query value (e.g. `painting`); null means "All".
class SearchTypeFilter {
  const SearchTypeFilter(this.label, this.type);

  final String label;
  final String? type;
}

const List<SearchTypeFilter> _searchTypeFilters = <SearchTypeFilter>[
  SearchTypeFilter('All', null),
  SearchTypeFilter('Paintings', 'painting'),
  SearchTypeFilter('Drawings', 'drawing'),
  SearchTypeFilter('Sculptures', 'sculpture'),
  SearchTypeFilter('Photographs', 'photograph'),
  SearchTypeFilter('Furniture', 'furniture'),
];

class SearchDetailPage extends StatefulWidget {
  final String searchTerm;
  final String? title;
  final Future<List<Art>> Function({required int page, required String term, String? type})? source;

  const SearchDetailPage({Key? key, required this.searchTerm, this.title, this.source}) : super(key: key);

  @visibleForTesting
  static const Key overscrollBoxKey = Key('overscroll-box');
  @visibleForTesting
  static const Key errorBoxKey = Key('error-box');
  @visibleForTesting
  static const Key emptyStateKey = Key('empty-state');

  @override
  _SearchDetailPageState createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  late final PagedSearchDataController controller =
      PagedSearchDataController(widget.source ?? context.repository.fetchSearchAll);

  final ValueNotifier<bool> singleColumn = ValueNotifier<bool>(false);

  late final Listenable combinedViewModel =
      Listenable.merge(<Listenable>[controller, singleColumn]);

  static const double loadMoreThreshold = 300;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  SearchTypeFilter _typeFilter = _searchTypeFilters.first;

  @override
  void initState() {
    controller.fetch(widget.searchTerm, type: _typeFilter.type).then(_onFinishedRequest);
    super.initState();
  }

  void _onTypeFilterSelected(SearchTypeFilter filter) {
    if (filter == _typeFilter) {
      return;
    }
    setState(() {
      _typeFilter = filter;
      _loadingStatus = LoadingStatus.initial;
    });
    controller.fetch(widget.searchTerm, type: filter.type).then(_onFinishedRequest);
  }

  @override
  void dispose() {
    controller.dispose();
    singleColumn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xff141213),
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(widget.title ?? widget.searchTerm),
                pinned: true,
                actions: null,
                backgroundColor: Color(0xff141213),
              ),
              if (widget.source == null)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      itemCount: _searchTypeFilters.length,
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final SearchTypeFilter filter = _searchTypeFilters[index];
                        final bool selected = filter == _typeFilter;
                        return Material(
                          color: selected ? const Color(0xffD2FCAC) : Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => _onTypeFilterSelected(filter),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              child: Text(
                                filter.label,
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
                ),
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
                          key: SearchDetailPage.errorBoxKey,
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
                          key: SearchDetailPage.emptyStateKey,
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
                key: SearchDetailPage.overscrollBoxKey,
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
                                key: SearchDetailPage.errorBoxKey,
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

  void _onRetry() =>
      controller.retry(widget.searchTerm, type: _typeFilter.type).then(_onFinishedRequest);

  void _onLoadMore() => controller
      .next(widget.searchTerm, type: _typeFilter.type)
      .then((_) => _loadingStatus = LoadingStatus.idle);

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
