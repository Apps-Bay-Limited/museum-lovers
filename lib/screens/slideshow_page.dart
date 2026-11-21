import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/screens/premium_page.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_saver.dart';
import 'package:museumLovers/widgets.dart';

/// Autoplay intervals offered in the slideshow's speed menu.
const Map<String, Duration> _autoplaySpeeds = <String, Duration>{
  'Slow': Duration(seconds: 5),
  'Medium': Duration(seconds: 3),
  'Fast': Duration(seconds: 1, milliseconds: 500),
};

/// Full-screen, swipeable artwork viewer with pinch-to-zoom and save support.
class SlideshowPage extends StatefulWidget {
  const SlideshowPage({Key? key, required this.arts, this.initialIndex = 0})
      : assert(arts.length > 0, 'Slideshow needs at least one artwork'),
        super(key: key);

  final List<Art> arts;
  final int initialIndex;

  @override
  State<SlideshowPage> createState() => _SlideshowPageState();
}

class _SlideshowPageState extends State<SlideshowPage> {
  late final PageController _pageController = PageController(initialPage: widget.initialIndex);
  late int _currentIndex = widget.initialIndex;
  bool _isDownloading = false;
  bool _isPlaying = false;
  Duration _autoplayInterval = _autoplaySpeeds['Medium']!;
  Timer? _autoplayTimer;

  Art get _currentArt => widget.arts[_currentIndex];

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _toggleAutoplay() async {
    if (!_isPlaying && !await ensurePremium(context)) {
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _restartAutoplay();
    } else {
      _autoplayTimer?.cancel();
    }
  }

  void _restartAutoplay() {
    _autoplayTimer?.cancel();
    if (widget.arts.length < 2) {
      return;
    }
    _autoplayTimer = Timer.periodic(_autoplayInterval, (_) {
      final int next = (_currentIndex + 1) % widget.arts.length;
      _pageController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void _selectSpeed(Duration interval) {
    setState(() => _autoplayInterval = interval);
    if (_isPlaying) {
      _restartAutoplay();
    }
  }

  Future<void> _saveCurrentImage() async {
    final String? url = _currentArt.webImage?.url;
    if (url == null || _isDownloading) {
      return;
    }
    await HapticFeedback.lightImpact();
    setState(() {
      _isDownloading = true;
    });
    await ImageSaver.save(url);
    if (mounted) {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canPlay = widget.arts.length > 1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: widget.arts.length,
            onPageChanged: (int index) => setState(() => _currentIndex = index),
            itemBuilder: (BuildContext context, int index) {
              final String? url = widget.arts[index].webImage?.url;
              if (url == null) {
                return const Center(child: Icon(Icons.broken_image_outlined, color: AppColors.textTertiary));
              }
              return InteractiveViewer(
                minScale: 1.0,
                maxScale: 5.0,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  placeholder: (BuildContext context, String url) => const LoadingSpinner(),
                  errorWidget: (BuildContext context, String url, dynamic error) =>
                      const Center(child: Icon(Icons.broken_image_outlined, color: AppColors.textTertiary)),
                ),
              );
            },
          ),
          // Top controls.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Row(
                  children: <Widget>[
                    OverlayIconButton(
                      icon: Icons.close_rounded,
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: const ShapeDecoration(color: AppColors.scrim, shape: StadiumBorder()),
                      child: Text(
                        '${_currentIndex + 1} / ${widget.arts.length}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    if (canPlay)
                      PopupMenuButton<Duration>(
                        tooltip: 'Autoplay speed',
                        onSelected: _selectSpeed,
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<Duration>>[
                          for (final MapEntry<String, Duration> entry in _autoplaySpeeds.entries)
                            CheckedPopupMenuItem<Duration>(
                              value: entry.value,
                              checked: entry.value == _autoplayInterval,
                              child: Text(entry.key),
                            ),
                        ],
                        child: const IgnorePointer(
                          child: OverlayIconButton(icon: Icons.speed_rounded, onPressed: null),
                        ),
                      )
                    else
                      const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),
          // Caption and actions over a soft bottom gradient.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.transparent, Color(0xcc000000)],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 48, 16, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _currentArt.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: displayStyle(18, color: Colors.white),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _currentArt.principalOrFirstMaker,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      _isDownloading
                          ? const SizedBox.square(
                              dimension: 44,
                              child: Padding(
                                padding: EdgeInsets.all(11),
                                child: CircularProgressIndicator(strokeWidth: 2.2, color: Colors.white),
                              ),
                            )
                          : OverlayIconButton(
                              icon: Icons.download_rounded,
                              tooltip: 'Save image',
                              size: 44,
                              onPressed: _saveCurrentImage,
                            ),
                      if (canPlay) ...<Widget>[
                        const SizedBox(width: 10),
                        Material(
                          color: AppColors.accent,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: _toggleAutoplay,
                            child: SizedBox.square(
                              dimension: 52,
                              child: Icon(
                                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                size: 28,
                                color: AppColors.onAccent,
                                semanticLabel: _isPlaying ? 'Pause' : 'Autoplay',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
