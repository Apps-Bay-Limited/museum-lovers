import 'package:flutter/material.dart';
import 'package:museumLovers/domain/models.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/widgets/art_grid_item.dart';
import 'package:museumLovers/widgets/error_display_view.dart';
import 'package:museumLovers/widgets/loading_spinner.dart';

import 'data_controller.dart';
import 'details_page.dart';

class SearchDetailPage extends StatefulWidget {
  final String searchTerm;
  const SearchDetailPage({Key? key, required this.searchTerm}) : super(key: key);

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
      PagedSearchDataController(context.repository.fetchSearchAll);

  final ValueNotifier<bool> singleColumn = ValueNotifier<bool>(false);

  late final Listenable combinedViewModel =
      Listenable.merge(<Listenable>[controller, singleColumn]);

  static const double overScrollOffset = 100;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  @override
  void initState() {
    controller.fetch(widget.searchTerm).then(_onFinishedRequest);
    super.initState();
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
                title: Text(widget.searchTerm),
                pinned: true,
                actions: null,
                backgroundColor: Color(0xff141213),
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
                  child: Container(color: const Color(0xff141213), height: overScrollOffset / 3),
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

  void _onRetry() => controller.retry(widget.searchTerm).then(_onFinishedRequest);

  void _onLoadMore() =>
      controller.next(widget.searchTerm).then((_) => _loadingStatus = LoadingStatus.idle);

  void _onFinishedRequest(void _) {
    if (!controller.hasError) {
      _loadingStatus = LoadingStatus.idle;
    }
  }

  void _onOverscroll() {
    if (_loadingStatus == LoadingStatus.idle) {
      _loadingStatus = LoadingStatus.loading;
      _onLoadMore();
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (Axis.vertical == notification.metrics.axis) {
      if (notification is ScrollUpdateNotification) {
        if (notification.metrics.pixels > notification.metrics.maxScrollExtent &&
            notification.metrics.pixels - notification.metrics.maxScrollExtent >=
                overScrollOffset) {
          _onOverscroll();
        }
        return true;
      }

      if (notification is OverscrollNotification) {
        if (notification.overscroll > 0) {
          _onOverscroll();
        }
        return true;
      }
    }
    return false;
  }
}

enum LoadingStatus { idle, initial, loading }
