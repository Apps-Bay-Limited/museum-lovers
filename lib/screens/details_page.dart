import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/favorites_page.dart';
import 'package:museumLovers/screens/premium_page.dart';
import 'package:museumLovers/screens/search_detail_page.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_saver.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/util/postcard_composer.dart';
import 'package:museumLovers/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'artist_page.dart';
import 'data_controller.dart';
import 'detail_full_page.dart';

void _openMaker(BuildContext context, ArtMaker? maker, {required String fallbackName}) {
  final String? id = maker?.id;
  final String name = maker?.name ?? fallbackName;
  if (name.isEmpty) {
    return;
  }
  Navigator.push<dynamic>(
    context,
    CupertinoPageRoute<dynamic>(
      builder: (BuildContext context) =>
          id == null ? SearchDetailPage(searchTerm: name) : ArtistPage(artistId: id, artistName: name),
    ),
  );
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.art}) : super(key: key);

  final Art art;

  static void go(BuildContext context, {required Art art}) =>
      Navigator.of(context).push<void>(MaterialPageRoute<void>(builder: (BuildContext context) => DetailsPage(art: art)));

  @visibleForTesting
  static const Key errorBoxKey = Key('error-box');

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _isSaving = false;
  bool _isSharingPostcard = false;

  late final DetailDataController controller = DetailDataController(context.repository.fetch, id: widget.art.objectNumber);

  String? get _imageUrl => widget.art.webImage?.url;

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

  void _openFullScreen() {
    final String? url = _imageUrl;
    if (url != null) {
      Navigator.push<dynamic>(context, CupertinoPageRoute<dynamic>(builder: (BuildContext context) => Detail(link: url)));
    }
  }

  Future<void> _saveImage() async {
    final String? url = _imageUrl;
    if (url == null || _isSaving) {
      return;
    }
    await HapticFeedback.lightImpact();
    setState(() => _isSaving = true);
    await ImageSaver.save(url);
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _sharePostcard() async {
    final String? url = _imageUrl;
    if (url == null || _isSharingPostcard || !await ensurePremium(context) || !mounted) {
      return;
    }
    await HapticFeedback.lightImpact();
    setState(() => _isSharingPostcard = true);
    try {
      final Uint8List imageBytes = await DefaultCacheManager().getSingleFile(url).then((file) => file.readAsBytes());
      final Uint8List postcard = await PostcardComposer.compose(
        imageBytes: imageBytes,
        title: widget.art.title,
        maker: widget.art.principalOrFirstMaker,
        credit: 'via $appName',
      );
      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[XFile.fromData(postcard, name: 'artwork.png', mimeType: 'image/png')],
          text: '${widget.art.title} — ${widget.art.principalOrFirstMaker}',
        ),
      );
    } catch (_) {
      await Fluttertoast.showToast(msg: 'Could not create the postcard. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSharingPostcard = false);
      }
    }
  }

  Future<void> _openWebsite() async {
    final String? url = widget.art.links.url;
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void _openArtist() {
    final List<ArtMaker> makers = controller.data?.principalMakers ?? const <ArtMaker>[];
    _openMaker(context, makers.isEmpty ? null : makers.first, fallbackName: widget.art.principalOrFirstMaker);
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = _imageUrl;
    final bool isPremium = context.appStore.isPremium;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
            automaticallyImplyLeading: false,
            title: _CollapsedTitle(widget.art.title),
            leadingWidth: 64,
            leading: Center(
              child: OverlayIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                tooltip: 'Back',
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
            actions: <Widget>[
              FavoriteButton(art: widget.art, iconSize: 20, padding: 10),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[StretchMode.zoomBackground],
              collapseMode: CollapseMode.parallax,
              background: imageUrl == null
                  ? const ColoredBox(color: AppColors.surface)
                  : Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _openFullScreen,
                          child: Hero(
                            tag: imageUrl,
                            child: CachedNetworkImage(
                              key: Key(imageUrl),
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (BuildContext context, String url) => Image(
                                image: CachedNetworkImageProvider(artImageUrl(imageUrl, kGridImageSize)),
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (BuildContext context, String url, dynamic error) => const Center(
                                  child: Icon(Icons.broken_image_outlined, color: AppColors.textTertiary)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: OverlayIconButton(
                            icon: Icons.open_in_full_rounded,
                            tooltip: 'View full screen',
                            size: 36,
                            onPressed: _openFullScreen,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.art.title, style: displayStyle(25)),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: _openArtist,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.brush_outlined, size: 16, color: AppColors.accent),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              widget.art.principalOrFirstMaker,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right, size: 18, color: AppColors.accent),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      _ActionButton(
                        icon: Icons.download_rounded,
                        label: 'Save',
                        busy: _isSaving,
                        onTap: imageUrl == null ? null : _saveImage,
                      ),
                      const SizedBox(width: 8),
                      _ActionButton(
                        icon: Icons.dashboard_customize_outlined,
                        label: 'Board',
                        locked: !isPremium,
                        onTap: () => showAddToBoardSheet(context, widget.art),
                      ),
                      const SizedBox(width: 8),
                      _ActionButton(
                        icon: Icons.mail_outline_rounded,
                        label: 'Postcard',
                        locked: !isPremium,
                        busy: _isSharingPostcard,
                        onTap: imageUrl == null ? null : _sharePostcard,
                      ),
                      if (widget.art.links.url != null) ...<Widget>[
                        const SizedBox(width: 8),
                        _ActionButton(icon: Icons.open_in_new_rounded, label: 'Website', onTap: _openWebsite),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              if (controller.isLoading) {
                return const SliverToBoxAdapter(child: SizedBox(height: 160, child: LoadingSpinner()));
              }
              if (controller.hasError) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 160,
                    child: Center(
                      key: DetailsPage.errorBoxKey,
                      child: ErrorDisplayView(message: controller.error!.message, onRetry: controller.retry),
                    ),
                  ),
                );
              }
              final ArtDetail? data = controller.data;
              if (data == null) {
                return const SliverToBoxAdapter(
                  child: EmptyState(
                    icon: Icons.info_outline,
                    title: 'Details unavailable',
                    message: 'The museum has no further information on this artwork.',
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                sliver: _DataView(key: Key(data.objectNumber), data: data),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.busy = false,
    this.locked = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool busy;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final Color color = onTap == null ? AppColors.textTertiary : AppColors.textPrimary;
    return Expanded(
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: busy ? null : onTap,
          child: SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox.square(
                  dimension: 24,
                  child: busy
                      ? const Padding(
                          padding: EdgeInsets.all(2),
                          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Icon(icon, size: 23, color: color),
                            if (locked)
                              Positioned(
                                right: -7,
                                top: -5,
                                child: Container(
                                  padding: const EdgeInsets.all(2.5),
                                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                                  child: const Icon(Icons.lock, size: 9, color: AppColors.onAccent),
                                ),
                              ),
                          ],
                        ),
                ),
                const SizedBox(height: 6),
                Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DataView extends StatefulWidget {
  const _DataView({Key? key, required this.data}) : super(key: key);

  final ArtDetail data;

  @override
  State<_DataView> createState() => _DataViewState();
}

class _DataViewState extends State<_DataView> {
  late final Future<List<Art>> _moreByArtistFuture = _loadMoreByArtist();

  Future<List<Art>> _loadMoreByArtist() async {
    final String maker = widget.data.principalOrFirstMaker;
    if (maker.isEmpty || maker == 'Anonymous') {
      return const <Art>[];
    }
    try {
      final List<Art> results = await context.repository.fetchSearchAll(page: 1, term: maker);
      return results.where((Art art) => art.id != widget.data.id).take(10).toList();
    } catch (_) {
      return const <Art>[];
    }
  }

  static String _formatDimensions(List<ArtDimension> dimensions) => dimensions.map((ArtDimension d) {
        final String? type = d.type;
        final String label = type == null || type.isEmpty ? '' : '${type[0].toUpperCase()}${type.substring(1)} ';
        final String value = d.value == d.value.roundToDouble() ? d.value.toStringAsFixed(0) : '${d.value}';
        final String part = d.part == null ? '' : ' (${d.part})';
        return '$label$value ${d.unit}$part';
      }).join('\n');

  void _searchColor(ArtColor color) {
    final String hex = '#${color.hex.replaceAll('#', '').trim().toUpperCase()}';
    Navigator.push<dynamic>(
      context,
      CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => SearchDetailPage(
          searchTerm: hex,
          title: 'Color $hex',
          source: ({required int page, required String term, String? type}) =>
              context.repository.fetchByColor(page: page, hex: term),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ArtDetail data = widget.data;
    final String description =
        data.label.description ?? data.plaqueDescriptionEnglish ?? data.description ?? '';
    final List<String> types = Set<String>.of(data.objectTypes + data.objectCollection).toList();
    final List<(String, Widget)> facts = <(String, Widget)>[
      if (data.dating.presentingDate.isNotEmpty) ('Date', _FactText(data.dating.presentingDate)),
      if (types.isNotEmpty) ('Type', _FactText(types.join(', '))),
      if (data.scLabelLine.isNotEmpty && data.scLabelLine != data.materials.join(', '))
        ('Medium', _FactText(data.scLabelLine)),
      if (data.materials.isNotEmpty) ('Materials', ArtMaterialRow(materials: data.materials)),
      if (data.techniques.isNotEmpty) ('Technique', _FactText(data.techniques.join(', '))),
      if (data.dimensions.isNotEmpty) ('Size', _FactText(_formatDimensions(data.dimensions))),
      if (data.productionPlaces.isNotEmpty) ('Made in', _FactText(data.productionPlaces.join(', '))),
      if (data.physicalProperties.isNotEmpty) ('Properties', _FactText(data.physicalProperties.join(', '))),
      if (data.historicalPersons.isNotEmpty) ('Depicts', _FactText(data.historicalPersons.join(', '))),
      if (data.galleryLocation != null) ('On display', _FactText(data.galleryLocation!)),
      if (data.inscriptions.isNotEmpty) ('Inscriptions', _FactText(data.inscriptions.join('\n'))),
      if (data.documentation.isNotEmpty) ('Sources', _FactText(data.documentation.join('\n'))),
      if (data.normalizedColors.isNotEmpty)
        ('Colors', ArtColorRow(colors: data.normalizedColors, onColorTap: _searchColor)),
    ];
    const EdgeInsets sectionPadding = EdgeInsets.fromLTRB(0, 26, 0, 10);

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        if (description.isNotEmpty) ExpandableText(description),
        if (facts.isNotEmpty) ...<Widget>[
          const SectionHeader('About this work', padding: sectionPadding),
          SurfaceCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < facts.length; i++) ...<Widget>[
                  if (i > 0) const Divider(),
                  _FactRow(label: facts[i].$1, child: facts[i].$2),
                ],
              ],
            ),
          ),
        ],
        if (data.principalMakers.isNotEmpty) ...<Widget>[
          SectionHeader(data.principalMakers.length > 1 ? 'Artists' : 'Artist', padding: sectionPadding),
          SurfaceCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < data.principalMakers.length; i++) ...<Widget>[
                  if (i > 0) const Divider(),
                  InkWell(
                    onTap: () => _openMaker(context, data.principalMakers[i], fallbackName: data.principalMaker),
                    child: ArtMakerItem(key: Key(data.principalMakers[i].name), maker: data.principalMakers[i]),
                  ),
                ],
              ],
            ),
          ),
        ],
        FutureBuilder<List<Art>>(
          future: _moreByArtistFuture,
          builder: (BuildContext context, AsyncSnapshot<List<Art>> snapshot) {
            final List<Art> works = snapshot.data ?? const <Art>[];
            if (works.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionHeader('More by ${data.principalOrFirstMaker}', padding: sectionPadding),
                ArtRail(
                  arts: works,
                  padding: EdgeInsets.zero,
                  onTap: (Art art) => DetailsPage.go(context, art: art),
                ),
              ],
            );
          },
        ),
      ]),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 96,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      );
}

class _FactText extends StatelessWidget {
  const _FactText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 14, height: 1.4));
}

/// App-bar title that only fades in once the hero image has collapsed.
class _CollapsedTitle extends StatelessWidget {
  const _CollapsedTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings? settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final double collapse = settings == null
        ? 1
        : 1 - ((settings.currentExtent - settings.minExtent) / 48).clamp(0.0, 1.0);
    return Opacity(
      opacity: collapse,
      child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: displayStyle(17)),
    );
  }
}
