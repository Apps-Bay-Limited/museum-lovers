import 'package:flutter/material.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/widgets.dart';

import 'data_controller.dart';
import 'details_page.dart';

/// Full artist biography, resolved from the Rijksmuseum Person record, with
/// a grid of the artist's other works below.
class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key, required this.artistId, required this.artistName}) : super(key: key);

  final String artistId;
  final String artistName;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late final Future<ArtMaker> _artistFuture = context.repository.fetchArtist(widget.artistId);

  late final PagedSearchDataController _worksController =
      PagedSearchDataController(context.repository.fetchSearchAll);

  final ValueNotifier<bool> _singleColumn = ValueNotifier<bool>(false);

  static const double _loadMoreThreshold = 300;
  _LoadingStatus _loadingStatus = _LoadingStatus.initial;

  @override
  void initState() {
    super.initState();
    _worksController.fetch(widget.artistName).then((_) {
      if (!_worksController.hasError) {
        _loadingStatus = _LoadingStatus.idle;
      }
    });
  }

  @override
  void dispose() {
    _worksController.dispose();
    _singleColumn.dispose();
    super.dispose();
  }

  void _onLoadMoreWhenIdle() {
    if (_loadingStatus == _LoadingStatus.idle) {
      _loadingStatus = _LoadingStatus.loading;
      _worksController.next(widget.artistName).then((_) => _loadingStatus = _LoadingStatus.idle);
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (Axis.vertical == notification.metrics.axis &&
        notification is ScrollUpdateNotification &&
        notification.metrics.pixels >= notification.metrics.maxScrollExtent - _loadMoreThreshold) {
      _onLoadMoreWhenIdle();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff141213),
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xff141213),
                title: Text(widget.artistName, maxLines: 1, overflow: TextOverflow.ellipsis),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: FutureBuilder<ArtMaker>(
                  future: _artistFuture,
                  builder: (BuildContext context, AsyncSnapshot<ArtMaker> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: LoadingSpinner(),
                      );
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: Text('Could not load this artist :(')),
                      );
                    }
                    return _ArtistHeader(artist: snapshot.data!, fallbackName: widget.artistName);
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Divider(color: Colors.white24),
                ),
              ),
              AnimatedBuilder(
                animation: _worksController,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == _LoadingStatus.initial && _worksController.isLoading) {
                    return const SliverToBoxAdapter(
                      child: Padding(padding: EdgeInsets.all(24), child: LoadingSpinner()),
                    );
                  }
                  final List<Art> works = _worksController.data;
                  if (works.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: Text('No other works found')),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Art art = works[index];
                          return ArtGridItem(
                            key: ValueKey<String>(art.id),
                            art: art,
                            onPressed: () => DetailsPage.go(context, art: art),
                          );
                        },
                        childCount: works.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

enum _LoadingStatus { idle, initial, loading }

class _ArtistHeader extends StatelessWidget {
  const _ArtistHeader({Key? key, required this.artist, required this.fallbackName}) : super(key: key);

  final ArtMaker artist;
  final String fallbackName;

  String? get _lifespan {
    final String? born = artist.dateOfBirth?.year.toString();
    final String? died = artist.dateOfDeath?.year.toString();
    if (born == null && died == null) {
      return null;
    }
    return '${born ?? '?'}–${died ?? 'present'}';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String displayName = fallbackName.isNotEmpty ? fallbackName : artist.name;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(radius: 32, child: Text(artist.initials)),
              AppSpacing.h4,
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(displayName, style: theme.textTheme.titleLarge),
                    if (_lifespan != null || artist.placeOfBirth != null) ...<Widget>[
                      AppSpacing.v2,
                      Text(
                        <String?>[_lifespan, artist.placeOfBirth].whereType<String>().join(' · '),
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                      ),
                    ],
                  ],
                ),
              ),
              FavoriteArtistButton(artist: artist),
            ],
          ),
          if (artist.occupation.isNotEmpty) ...<Widget>[
            AppSpacing.v12,
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final String occupation in artist.occupation)
                  Chip(
                    label: Text(occupation, style: const TextStyle(color: Color(0xffD2FCAC))),
                    backgroundColor: Colors.white10,
                    side: BorderSide.none,
                  ),
              ],
            ),
          ],
          if (artist.biography != null && artist.biography!.isNotEmpty) ...<Widget>[
            AppSpacing.v16,
            Text(artist.biography!, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
          ],
        ],
      ),
    );
  }
}
