import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumLovers/util/image_saver.dart';

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
      backgroundColor: const Color(0xff141214),
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
                      color: Colors.white30,
                      size: min(MediaQuery.of(context).size.width / 3, 150),
                    ),
                  );
                },
                errorWidget: (BuildContext context, String url, dynamic error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
        Positioned(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              tooltip: 'Back',
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: _saveImage,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(Icons.cloud_download_rounded),
                ),
              ),
            ),
          ),
        ),
        if (isDowloading)
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
