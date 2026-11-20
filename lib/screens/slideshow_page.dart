import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/domain.dart';
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

  void _toggleAutoplay() {
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
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff141214),
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: widget.arts.length,
            onPageChanged: (int index) => setState(() => _currentIndex = index),
            itemBuilder: (BuildContext context, int index) {
              final String? url = widget.arts[index].webImage?.url;
              if (url == null) {
                return const Center(child: Icon(Icons.broken_image_outlined, color: Colors.white30));
              }
              return InteractiveViewer(
                minScale: 1.0,
                maxScale: 5.0,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  placeholder: (BuildContext context, String url) => const LoadingSpinner(),
                  errorWidget: (BuildContext context, String url, dynamic error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('${_currentIndex + 1} / ${widget.arts.length}'),
              centerTitle: true,
              actions: widget.arts.length < 2
                  ? null
                  : <Widget>[
                      PopupMenuButton<Duration>(
                        tooltip: 'Autoplay speed',
                        icon: const Icon(Icons.speed, color: Colors.white),
                        onSelected: _selectSpeed,
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<Duration>>[
                          for (final MapEntry<String, Duration> entry in _autoplaySpeeds.entries)
                            CheckedPopupMenuItem<Duration>(
                              value: entry.value,
                              checked: entry.value == _autoplayInterval,
                              child: Text(entry.key),
                            ),
                        ],
                      ),
                      IconButton(
                        tooltip: _isPlaying ? 'Pause' : 'Autoplay',
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                        onPressed: _toggleAutoplay,
                      ),
                    ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _currentArt.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          _currentArt.principalOrFirstMaker,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: _saveCurrentImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Icon(Icons.cloud_download_rounded),
                          ),
                        ),
                      ),
                      if (_isDownloading)
                        const SizedBox(
                          width: 52,
                          height: 52,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
