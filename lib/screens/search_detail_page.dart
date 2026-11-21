import 'package:flutter/material.dart';
import 'package:museumLovers/domain/models.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/widgets.dart';

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

  const SearchDetailPage({super.key, required this.searchTerm, this.title, this.source});

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(widget.title ?? widget.searchTerm, maxLines: 1, overflow: TextOverflow.ellipsis),
                pinned: true,
              ),
              if (widget.source == null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 6),
                    child: ChipRail(
                      children: <Widget>[
                        for (final SearchTypeFilter filter in _searchTypeFilters)
                          PillChip(
                            label: filter.label,
                            selected: filter == _typeFilter,
                            onTap: () => _onTypeFilterSelected(filter),
                          ),
                      ],
                    ),
                  ),
                ),
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == LoadingStatus.initial) {
                    if (controller.isLoading) {
                      return const SliverFillRemaining(child: LoadingSpinner());
                    }
                    if (controller.hasError) {
                      return SliverFillRemaining(
                        child: Center(
                          key: SearchDetailPage.errorBoxKey,
                          child: ErrorDisplayView(message: controller.error!.message, onRetry: _onRetry),
                        ),
                      );
                    }
                  }

                  final List<Art> items = controller.data;
                  if (items.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        key: SearchDetailPage.emptyStateKey,
                        icon: Icons.search_off_rounded,
                        title: 'No artworks found',
                        message: _typeFilter.type == null
                            ? 'Try a different spelling, or search for an artist or subject.'
                            : 'Nothing in ${_typeFilter.label.toLowerCase()} — try “All”.',
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: kArtGridPadding,
                    sliver: SliverGrid.builder(
                      gridDelegate: kArtGridDelegate,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Art art = items[index];
                        return ArtGridItem(
                          key: ValueKey<String>(art.id),
                          art: art,
                          onPressed: () => DetailsPage.go(context, art: art),
                        );
                      },
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                key: SearchDetailPage.overscrollBoxKey,
                child: AnimatedBuilder(
                  animation: controller,
                  child: const SizedBox(height: 32),
                  builder: (BuildContext context, Widget? child) {
                    if (_loadingStatus == LoadingStatus.initial || !(controller.isLoading || controller.hasError)) {
                      return child!;
                    }
                    return SafeArea(
                      top: false,
                      child: SizedBox(
                        height: kToolbarHeight,
                        child: controller.isLoading
                            ? const LoadingSpinner()
                            : Padding(
                                key: SearchDetailPage.errorBoxKey,
                                padding: const EdgeInsets.all(8),
                                child: ErrorDisplayView(
                                  message: controller.error!.message,
                                  onRetry: _onRetry,
                                  direction: Axis.horizontal,
                                ),
                              ),
                      ),
                    );
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
