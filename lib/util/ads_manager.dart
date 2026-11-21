import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config/app_config.dart';

class AdsManager {
  static bool disableAllAdsForScreenshot = false;

  /// Set once UMP consent has been gathered and [MobileAds] initialized.
  /// No ad should be requested before this is true.
  static bool adsAllowed = false;

  static String get bannerAdUnitId {
    if (disableAllAdsForScreenshot) return "";
    return AppConfig.bannerAdUnitId;
  }

  static String get openAdUnitID {
    if (disableAllAdsForScreenshot) return "";
    return AppConfig.openAdUnitId;
  }

  static String get rewardedAdUnitID {
    if (disableAllAdsForScreenshot) return "";
    return AppConfig.rewardedAdUnitId;
  }

  static void debugPrintID() {
    print("bannerAdUnitId: ${AdsManager.bannerAdUnitId}");
    print("openAdUnitID: ${AdsManager.openAdUnitID}");
  }
}

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  /// Load an AppOpenAd. No-op until UMP consent has cleared ad requests.
  void loadAd() {
    if (!AdsManager.adsAllowed) return;
    AppOpenAd.load(
      adUnitId: AdsManager.openAdUnitID,
      // orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded');
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable({bool adFree = false}) {
    if (adFree) {
      return;
    }
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }

    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

/// Lets the user watch a short rewarded video in exchange for a day without
/// ads ("Remove ads for 24 hours" in Settings).
class RewardedAdManager {
  RewardedAdManager._();

  static RewardedAd? _ad;
  static bool _isLoading = false;

  /// Preloads a rewarded ad so one is likely ready by the time the user asks
  /// for it. Safe to call repeatedly (e.g. from Settings' initState).
  static void preload() {
    if (!AdsManager.adsAllowed || _isLoading || _ad != null) {
      return;
    }
    _isLoading = true;
    RewardedAd.load(
      adUnitId: AdsManager.rewardedAdUnitID,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _ad = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _isLoading = false;
        },
      ),
    );
  }

  /// Shows the preloaded ad if one is ready, calling [onRewarded] only once
  /// the user actually earns the reward (finishes the video), or
  /// [onUnavailable] immediately if no ad is ready yet.
  static Future<void> showForAdFreeDay({
    required VoidCallback onRewarded,
    required VoidCallback onUnavailable,
  }) async {
    final RewardedAd? ad = _ad;
    if (ad == null) {
      onUnavailable();
      preload();
      return;
    }
    _ad = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
        ad.dispose();
        preload();
      },
      onAdDismissedFullScreenContent: (Ad ad) {
        ad.dispose();
        preload();
      },
    );
    await ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) => onRewarded());
  }
}

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;

  /// Checked right before showing an app-open ad, so a user who just
  /// watched a rewarded ad for an ad-free day isn't interrupted by one.
  final bool Function() isAdFree;

  bool hasEnterBackground = false;

  AppLifecycleReactor({required this.appOpenAdManager, this.isAdFree = _never});

  static bool _never() => false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    print("didChangeAppLifecycleState: $state");
    if (state == AppLifecycleState.paused) {
      hasEnterBackground = true;
    }
    if (state == AppLifecycleState.resumed && hasEnterBackground) {
      appOpenAdManager.showAdIfAvailable(adFree: isAdFree());
      hasEnterBackground = false;
    }
  }
}
