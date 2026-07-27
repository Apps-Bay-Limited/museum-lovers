import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/search_detail_page.dart';
import 'package:museumLovers/util/image_saver.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

import 'artist_page.dart';
import 'data_controller.dart';
import 'detail_full_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.art}) : super(key: key);

  final Art art;

  static void go(BuildContext context, {required Art art}) =>
      Navigator.of(context).push<void>(MaterialPageRoute<void>(
          builder: (BuildContext context) => DetailsPage(art: art)));

  @visibleForTesting
  static const Key errorBoxKey = Key('error-box');
  @visibleForTesting
  static const Key zoomButtonKey = Key('zoom-button');

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isDowloading = false;

  late final DetailDataController controller = DetailDataController(
      context.repository.fetch,
      id: widget.art.objectNumber);

  @override
  void initState() {
    controller.fetch();
    super.initState();
    // Deferred to a post-frame callback: calling this synchronously here
    // notifies AppStoreProvider's listeners while this page is still being
    // mounted/built, which throws a "setState() called during build" error.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        AppStoreProvider.read(context).addRecentlyViewed(widget.art);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff141213),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: const Color(0xff141213),
              // title: Text(widget.art.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              actions: <Widget>[
                Container(
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.black45),
                  child: Center(
                    child: FavoriteButton(
                      art: widget.art,
                      iconSize: 25,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.black45),
                  child: InkWell(
                    // borderRadius: BorderRadius.circular(25),
                    // type: MaterialType.transparency,
                    child: IconButton(
                        iconSize: 25,
                        onPressed: () {
                          final String? url = widget.art.webImage?.url;
                          if (url != null) {
                            Navigator.push<dynamic>(
                              context,
                              CupertinoPageRoute<dynamic>(
                                builder: (BuildContext context) => Detail(
                                  link: url,
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.fullscreen_rounded)),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Stack(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.black45),
                      child: InkWell(
                        // borderRadius: BorderRadius.circular(25),
                        // type: MaterialType.transparency,
                        child: IconButton(
                            tooltip: 'Save image',
                            iconSize: 25,
                            onPressed: () async {
                              final String? url = widget.art.webImage?.url;
                              if (url == null || isDowloading) {
                                return;
                              }
                              await HapticFeedback.lightImpact();
                              setState(() {
                                isDowloading = true;
                              });
                              await ImageSaver.save(url);
                              if (mounted) {
                                setState(() {
                                  isDowloading = false;
                                });
                              }
                            },
                            icon: const Icon(Icons.cloud_download_rounded)),
                      ),
                    ),
                    if (isDowloading)
                      const Center(
                        child: SizedBox(
                          height: 53,
                          width: 53,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                    width: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.black45),
                    child: ArtLinksButton(links: widget.art.links)),
                const SizedBox(
                  width: 12,
                )
              ],
              pinned: true,
              stretch: true,
              expandedHeight: MediaQuery.of(context).size.height / 1.61,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.art.webImage?.url != null
                    ? InkWell(
                        onTap: () {
                          final String? url = widget.art.webImage?.url;
                          if (url != null) {
                            Navigator.push<dynamic>(
                              context,
                              CupertinoPageRoute<dynamic>(
                                builder: (BuildContext context) => Detail(
                                  link: url,
                                ),
                              ),
                            );
                          }
                        },
                        child: Hero(
                          tag: widget.art.webImage!.url!,
                          child: CachedNetworkImage(
                            key: Key(widget.art.webImage!.url!),
                            imageUrl: widget.art.webImage!.url!,
                            fit: BoxFit.cover,
                            placeholder: (BuildContext context, String url) => Image(
                              image: CachedNetworkImageProvider(
                                  artImageUrl(widget.art.webImage!.url!, kGridImageSize)),
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (BuildContext context, String url, dynamic error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ))
                    : null,
                stretchModes: const <StretchMode>[StretchMode.zoomBackground],
                collapseMode: CollapseMode.parallax,
              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                if (controller.isLoading) {
                  return const SliverFillRemaining(child: LoadingSpinner());
                }
                if (controller.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      key: DetailsPage.errorBoxKey,
                      child: ErrorDisplayView(
                          message: controller.error!.message,
                          onRetry: controller.retry),
                    ),
                  );
                }

                final ArtDetail? data = controller.data;
                if (data == null) {
                  return const SliverFillRemaining(
                      child:
                          Center(child: Text('Could not find art work? :(')));
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 48),
                  sliver: _DataView(key: Key(data.objectNumber), data: data),
                );
              },
            ),
          ],
        ),
      );
}

class _DataView extends StatefulWidget {
  final ArtDetail data;

  const _DataView({Key? key, required this.data}) : super(key: key);

  @override
  __DataViewState createState() => __DataViewState();
}

class __DataViewState extends State<_DataView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        AppSpacing.v16,
        Text(widget.data.title, style: textTheme.headlineSmall),
        AppSpacing.v8,
        // if (data.physicalMedium != null) ...<Widget>[
        //   Text(data.physicalMedium!, style: textTheme.caption?.copyWith(fontSize: 14)),
        //   AppSpacing.v8,
        // ],
        Wrap(
          spacing: 4,
          children: <Widget>[
            for (final String type in Set<String>.of(
                widget.data.objectTypes + widget.data.objectCollection))
              InkWell(
                child: Chip(
                    key: Key(type),
                    label: Text(
                      type,
                      style: const TextStyle(color: Color(0xffD2FCAC)),
                    ),
                    labelStyle: textTheme.bodyLarge),
                onTap: () {
                  Navigator.of(context).push<void>(MaterialPageRoute<void>(
                      builder: (BuildContext context) => SearchDetailPage(
                            searchTerm: type,
                          )));
                },
              ),
          ],
        ),
        AppSpacing.v16,
        const Divider(
          color: Colors.white60,
        ),
        AppSpacing.v16,
        InkWell(
          onTap: () => _openMaker(context, widget.data.principalMakers.isEmpty
              ? null
              : widget.data.principalMakers.first),
          child: Row(children: <Widget>[
            const Icon(Icons.brush_rounded, size: 20),
            AppSpacing.h4,
            Text(widget.data.principalMaker, style: textTheme.titleLarge),
          ]),
        ),
        AppSpacing.v10,
        Text(
          widget.data.label.description ??
              widget.data.plaqueDescriptionEnglish ??
              widget.data.description ??
              'N/A',
          style: textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        AppSpacing.v16,
        Text(widget.data.scLabelLine, style: textTheme.bodySmall),
        if (widget.data.webImage?.url != null) ...<Widget>[
          AppSpacing.v4,
          AspectRatio(
            aspectRatio: widget.data.webImage!.aspectRatio,
            child: Stack(
              children: <Widget>[
                CachedImage(
                  url: widget.data.webImage!.url!,
                  builder: (ImageProvider<Object> provider) =>
                      Ink.image(image: provider, fit: BoxFit.cover),
                ),
                IconButton(
                  key: DetailsPage.zoomButtonKey,
                  onPressed: () => showDialog<void>(
                      context: context,
                      builder: (_) =>
                          ImageDialog(url: widget.data.webImage!.url!)),
                  icon: const Icon(Icons.zoom_out_map),
                )
              ],
            ),
          ),
          AppSpacing.v4,
        ],
        ArtColorRow(
          colors: widget.data.normalizedColors,
          onColorTap: (ArtColor color) {
            final String hex = '#${color.hex.replaceAll('#', '').trim().toUpperCase()}';
            Navigator.push<dynamic>(
              context,
              CupertinoPageRoute<dynamic>(
                builder: (BuildContext context) => SearchDetailPage(
                  searchTerm: hex,
                  title: 'Color $hex',
                  source: ({required int page, required String term}) =>
                      context.repository.fetchByColor(page: page, hex: term),
                ),
              ),
            );
          },
        ),
        AppSpacing.v2,
        ArtMaterialRow(materials: widget.data.materials),
        AppSpacing.v16,
        const Divider(
          color: Colors.white60,
        ),
        AppSpacing.v16,
        if (widget.data.dimensions.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Dimensions'),
          AppSpacing.v8,
          for (final ArtDimension dimension in widget.data.dimensions)
            ArtDimensionItem(
                key: Key(dimension.toString()), dimension: dimension),
          AppSpacing.v12,
        ],
        const _SectionHeaderText('Principal makers'),
        AppSpacing.v8,
        for (final ArtMaker maker in widget.data.principalMakers)
          InkWell(
              onTap: () => _openMaker(context, maker),
              child: ArtMakerItem(key: Key(maker.name), maker: maker)),
        AppSpacing.v12,
        if (widget.data.productionPlaces.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Production places'),
          AppSpacing.v8,
          Text(widget.data.productionPlaces.join(', '),
              style: textTheme.bodyMedium),
          AppSpacing.v12,
        ],
        if (widget.data.techniques.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Techniques'),
          AppSpacing.v8,
          Text(widget.data.techniques.join(', '), style: textTheme.bodyMedium),
          AppSpacing.v12,
        ],
        if (widget.data.physicalProperties.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Physical properties'),
          AppSpacing.v8,
          Text(widget.data.physicalProperties.join(', '),
              style: textTheme.bodyMedium),
          AppSpacing.v12,
        ],
        if (widget.data.historicalPersons.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Historical persons'),
          AppSpacing.v8,
          Text(widget.data.historicalPersons.join(', '),
              style: textTheme.bodyMedium),
          AppSpacing.v12,
        ],
        if (widget.data.inscriptions.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Inscriptions'),
          AppSpacing.v8,
          Text('— ' + widget.data.inscriptions.join('\n— '),
              style: textTheme.bodyMedium?.copyWith(height: 1.25)),
          AppSpacing.v12,
        ],
        if (widget.data.galleryLocation != null) ...<Widget>[
          const _SectionHeaderText('On display'),
          AppSpacing.v8,
          Row(children: <Widget>[
            const Icon(Icons.location_on_outlined, size: 18),
            AppSpacing.h4,
            Expanded(child: Text(widget.data.galleryLocation!, style: textTheme.bodyMedium)),
          ]),
          AppSpacing.v12,
        ],
        if (widget.data.documentation.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Documentation'),
          AppSpacing.v8,
          Text('— ' + widget.data.documentation.join('\n— '),
              style: textTheme.bodyMedium?.copyWith(height: 1.25)),
          AppSpacing.v12,
        ],
        AppSpacing.v24,
      ]),
    );
  }

  void _openMaker(BuildContext context, ArtMaker? maker) {
    if (maker == null) {
      return;
    }
    final String? id = maker.id;
    Navigator.push<dynamic>(
      context,
      CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => id == null
            ? SearchDetailPage(searchTerm: maker.name)
            : ArtistPage(artistId: id, artistName: maker.name),
      ),
    );
  }
}

class _SectionHeaderText extends StatelessWidget {
  const _SectionHeaderText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text(
        data,
        style: textTheme.titleLarge?.copyWith(
          letterSpacing: .85,
          height: 1.5,
          // decoration: TextDecoration.underline,
          // decorationStyle: TextDecorationStyle.double,
          fontStyle: FontStyle.italic,
          decorationColor: textTheme.bodySmall?.color,
          color: Colors.white,
        ),
        key: Key(data),
      ),
    );
  }
}
