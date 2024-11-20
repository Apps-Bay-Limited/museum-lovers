import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/util/in_app_reviewer_helper.dart';

import 'app.dart';
import 'data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // FlutterConfiguration.instance.enableImpeller = false;

  Future.delayed(const Duration(seconds: 1), () {
    AppTrackingTransparency.requestTrackingAuthorization();
  });
  MobileAds.instance.initialize();

  AdsManager.debugPrintID();

  InAppReviewHelper.checkAndAskForReview();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(App(
      repository: HttpRijksRepository(Client(), apiKey: 'MR7OUoVp'),
    ));
  });
}
