import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/util/in_app_reviewer_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'config/app_config.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FlutterConfiguration.instance.enableImpeller = false;

  Future.delayed(const Duration(seconds: 1), () {
    AppTrackingTransparency.requestTrackingAuthorization();
  });
  MobileAds.instance.initialize();

  AdsManager.debugPrintID();

  InAppReviewHelper.checkAndAskForReview();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App(
    repository: HttpRijksRepository(Client(), apiKey: AppConfig.rijksmuseumApiKey),
    store: AppStore(prefs),
  ));
}
