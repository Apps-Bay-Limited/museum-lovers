import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final String link;
  Detail({required this.link});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isDowloading = false;
  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.link,
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(
                imageUrl: widget.link,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(
                    child: Icon(
                      Icons.brush_rounded,
                      color: Colors.white30,
                      size: min(MediaQuery.of(context).size.width / 3, 150),
                    ),
                  );
                },
                errorWidget: (context, url, dynamic error) => Container(
                    color: const Color(
                  0xff141214,
                )),
              )),
        ),
        Positioned(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
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
              onTap: () async {
                await HapticFeedback.lightImpact();
                setState(() {
                  isDowloading = true;
                });
                final File file = await DefaultCacheManager().getSingleFile(widget.link);

                setState(() {
                  isDowloading = false;
                });

                final Uint8List pngBytes = await file.readAsBytes();

                if (kDebugMode) {
                  print(await Permission.photosAddOnly.status);
                }

                if (Platform.isIOS) {
                  final IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
                  final String iOSVersion = iosInfo.systemVersion!;
                  print(iOSVersion);
                  if (iOSVersion.compareTo("14.0") < 0) {
                    // iOS < 14.0

                    // await saveImageToPhotoApp(pngBytes, context);
                  } else {
                    // iOS >= 14.0
                    if (await Permission.photosAddOnly.request().isGranted) {
                      // await saveImageToPhotoApp(pngBytes, context);
                    } else {
                      await showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                                title: const Text('Photo Permission'),
                                content: const Text('This App needs permission to save photos'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Cancel'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('Settings'),
                                    onPressed: () => openAppSettings(),
                                  ),
                                ],
                              ));
                    }
                  }
                } else {
                  // await saveImageToPhotoApp(pngBytes, context);
                }
              },
              child: Container(
                margin: EdgeInsets.all(10),
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

// Future<void> saveImageToPhotoApp(Uint8List pngBytes, BuildContext context) async {
//   final dynamic result =
//       await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes), quality: 60, name: "hello");
//   print(result);
//
//   if ((result['isSuccess'] as bool) == true) {
//     FToast fToast = FToast();
//     fToast.init(context);
//
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: Color(0xff333333),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const Text("Saved to the photo album", style: TextStyle(color: Colors.white)),
//           if (Platform.isIOS)
//             TextButton(
//                 onPressed: () async {
//                   String _url = "photos-redirect://";
//                   if (await canLaunch(_url)) {
//                     await launch(_url);
//                   }
//                 },
//                 child: Text("Open",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
//         ],
//       ),
//     );
//
//     fToast.showToast(
//       child: toast,
//       gravity: ToastGravity.TOP,
//       toastDuration: Duration(seconds: 2),
//     );
//   }
// }
