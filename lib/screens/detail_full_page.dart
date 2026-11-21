import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/util/image_saver.dart';
import 'package:museumLovers/widgets.dart';

class Detail extends StatefulWidget {
  final String link;
  const Detail({Key? key, required this.link}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isDowloading = false;

  Future<void> _saveImage() async {
    if (isDowloading) {
      return;
    }
    await HapticFeedback.lightImpact();
    setState(() {
      isDowloading = true;
    });
    await ImageSaver.save(widget.link);
    if (mounted) {
      setState(() {
        isDowloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: <Widget>[
        Positioned.fill(
          child: Hero(
            tag: widget.link,
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 5.0,
              child: CachedNetworkImage(
                imageUrl: widget.link,
                fit: BoxFit.contain,
                placeholder: (BuildContext context, String url) {
                  return Center(
                    child: Icon(
                      Icons.brush_rounded,
                      color: Colors.white24,
                      size: min(MediaQuery.of(context).size.width / 3, 150),
                    ),
                  );
                },
                errorWidget: (BuildContext context, String url, dynamic error) =>
                    const Center(child: Icon(Icons.broken_image_outlined, color: Colors.white38)),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverlayIconButton(
                    icon: Icons.close_rounded,
                    tooltip: 'Close',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: isDowloading
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
                            onPressed: _saveImage,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
