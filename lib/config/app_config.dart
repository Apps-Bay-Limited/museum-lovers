import 'dart:io';

import 'package:flutter/foundation.dart';

import '../secrets.dart';

class AppConfig {
  AppConfig._();

  static String get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
      if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    }
    if (Platform.isAndroid) return Secrets.bannerAdUnitIdAndroid;
    if (Platform.isIOS) return Secrets.bannerAdUnitIdIOS;
    throw UnsupportedError('Unsupported platform');
  }

  static String get openAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/3419835294';
      if (Platform.isIOS) return 'ca-app-pub-3940256099942544/5575463023';
    }
    if (Platform.isAndroid) return Secrets.openAdUnitIDAndroid;
    if (Platform.isIOS) return Secrets.openAdUnitIDIOS;
    throw UnsupportedError('Unsupported platform');
  }

  static String get rijksmuseumApiKey => Secrets.rijksmuseumApiKey;
}
