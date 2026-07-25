import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';

/// Saves artwork images to the device's photo library.
class ImageSaver {
  ImageSaver._();

  /// Downloads the image at [url] (through the shared cache) and saves it
  /// to the photo gallery, asking for permission when needed.
  static Future<void> save(String url) async {
    try {
      final bool hasAccess = await Gal.hasAccess();
      if (!hasAccess && !await Gal.requestAccess()) {
        await Fluttertoast.showToast(
            msg: 'Photo access denied. Enable it in Settings to save images.');
        return;
      }

      final Uint8List bytes =
          await DefaultCacheManager().getSingleFile(url).then((file) => file.readAsBytes());
      await Gal.putImageBytes(bytes);
      await Fluttertoast.showToast(msg: 'Saved to your photo library');
    } on GalException catch (e) {
      await Fluttertoast.showToast(
          msg: e.type == GalExceptionType.accessDenied
              ? 'Photo access denied. Enable it in Settings to save images.'
              : 'Could not save the image. Please try again.');
    } catch (_) {
      await Fluttertoast.showToast(msg: 'Could not save the image. Please try again.');
    }
  }
}
