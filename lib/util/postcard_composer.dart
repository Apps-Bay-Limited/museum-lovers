import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Composes a shareable "postcard" PNG from an artwork image: the image
/// itself with a bottom gradient and the title/maker burned in, drawn
/// directly on a [Canvas] (rather than captured from the widget tree, which
/// would need a hidden-but-painted widget and is easy to get subtly wrong).
class PostcardComposer {
  PostcardComposer._();

  static Future<Uint8List> compose({
    required Uint8List imageBytes,
    required String title,
    required String maker,
    required String credit,
  }) async {
    final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image image = frame.image;
    final double width = image.width.toDouble();
    final double height = image.height.toDouble();

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width, height));

    canvas.drawImage(image, Offset.zero, Paint());

    final double gradientHeight = height * 0.32;
    final double gradientTop = height - gradientHeight;
    canvas.drawRect(
      Rect.fromLTWH(0, gradientTop, width, gradientHeight),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, gradientTop),
          Offset(0, height),
          <Color>[Colors.transparent, Colors.black.withValues(alpha: 0.88)],
        ),
    );

    final double pad = width * 0.045;
    final double maxTextWidth = width - pad * 2;

    final TextPainter titlePainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.045, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '…',
    )..layout(maxWidth: maxTextWidth);

    final TextPainter makerPainter = TextPainter(
      text: TextSpan(text: maker, style: TextStyle(color: Colors.white70, fontSize: width * 0.03)),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxTextWidth);

    final TextPainter creditPainter = TextPainter(
      text: TextSpan(text: credit, style: TextStyle(color: Colors.white38, fontSize: width * 0.022)),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxTextWidth);

    final double textBlockHeight = titlePainter.height + 6 + makerPainter.height;
    double textTop = gradientTop + (gradientHeight - creditPainter.height - pad - textBlockHeight) / 2;
    textTop = textTop.clamp(gradientTop + pad / 2, height - pad - creditPainter.height - textBlockHeight - 6);

    titlePainter.paint(canvas, Offset(pad, textTop));
    makerPainter.paint(canvas, Offset(pad, textTop + titlePainter.height + 6));
    creditPainter.paint(canvas, Offset(pad, height - pad - creditPainter.height));

    final ui.Picture picture = recorder.endRecording();
    final ui.Image finalImage = await picture.toImage(width.round(), height.round());
    final ByteData? pngBytes = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    if (pngBytes == null) {
      throw StateError('Could not encode postcard image');
    }
    return pngBytes.buffer.asUint8List();
  }
}
