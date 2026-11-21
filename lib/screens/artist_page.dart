import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/widgets.dart';

import 'data_controller.dart';
import 'details_page.dart';

/// Full artist biography, resolved from the Rijksmuseum Person record, with
/// a grid of the artist's other works below.
class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key, required this.artistId, required this.artistName});

  final String artistId;
  final String artistName;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late final Future<ArtMaker> _artistFuture = context.repository.fetchArtist(widget.artistId);

  late final PagedSearchDataController _worksController =
      PagedSearchDataController(context.repository.fetchSearchAll);

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
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(pinned: true),
              SliverToBoxAdapter(
                child: FutureBuilder<ArtMaker>(
                  future: _artistFuture,
                  builder: (BuildContext context, AsyncSnapshot<ArtMaker> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const SizedBox(height: 140, child: LoadingSpinner());
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return _ArtistHeader(
                        artist: ArtMaker(
                          id: widget.artistId,
                          name: widget.artistName,
                          unFixedName: widget.artistName,
                          occupation: const <String>[],
                          roles: const <String>[],
                          labelDesc: '',
                        ),
                        fallbackName: widget.artistName,
                      );
                    }
                    return _ArtistHeader(artist: snapshot.data!, fallbackName: widget.artistName);
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _worksController,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == _LoadingStatus.initial && _worksController.isLoading) {
                    return const SliverToBoxAdapter(child: SizedBox(height: 160, child: LoadingSpinner()));
                  }
                  final List<Art> works = _worksController.data;
                  if (works.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: EmptyState(
                        icon: Icons.image_search_rounded,
                        title: 'No works found',
                        message: 'The collection has no other works listed under this name.',
                      ),
                    );
                  }
                  return SliverMainAxisGroup(
                    slivers: <Widget>[
                      const SliverToBoxAdapter(child: SectionHeader('Works in the collection')),
                      SliverPadding(
                        padding: kArtGridPadding.copyWith(top: 0),
                        sliver: SliverGrid.builder(
                          gridDelegate: kArtGridDelegate,
                          itemCount: works.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Art art = works[index];
                            return ArtGridItem(
                              key: ValueKey<String>(art.id),
                              art: art,
                              onPressed: () => DetailsPage.go(context, art: art),
                            );
                          },
                        ),
                      ),
                    ],
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
  const _ArtistHeader({required this.artist, required this.fallbackName});

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
    final String displayName = fallbackName.isNotEmpty ? fallbackName : artist.name;
    final String meta = <String?>[_lifespan, artist.placeOfBirth].whereType<String>().join(' · ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              InitialsAvatar(displayName, size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(displayName, style: displayStyle(24)),
                    if (meta.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 4),
                      Text(meta, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              if (artist.id != null) FavoriteArtistButton(artist: artist),
            ],
          ),
          if (artist.occupation.isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final String occupation in artist.occupation.toSet())
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: ShapeDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      occupation,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.accent),
                    ),
                  ),
              ],
            ),
          ],
          if (artist.biography != null && artist.biography!.isNotEmpty) ...<Widget>[
            const SizedBox(height: 16),
            ExpandableText(artist.biography!),
          ],
        ],
      ),
    );
  }
}
