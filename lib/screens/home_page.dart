import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/search_detail_page.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/widgets.dart';

import 'data_controller.dart';
import 'details_page.dart';

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
  late final PagedDataController controller = PagedDataController(context.repository.fetchAll);
  final TextEditingController _inputController = TextEditingController();

  final ValueNotifier<bool> singleColumn = ValueNotifier<bool>(false);

  late final Listenable combinedViewModel =
      Listenable.merge(<Listenable>[controller, singleColumn]);

  static const double overScrollOffset = 100;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  @override
  void initState() {
    controller.fetch().then(_onFinishedRequest);
    super.initState();

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance?.addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager));
  }

  @override
  void dispose() {
    controller.dispose();
    singleColumn.dispose();
    _inputController.dispose();
    super.dispose();
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
                        color: Colors.grey,
                      ),
                      controller: _inputController,
                      onChanged: (String value) {},
                      onSubmitted: (String value) {
                        if (value.isNotEmpty == true) {
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
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Search art work or author name'),
                    )),
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
