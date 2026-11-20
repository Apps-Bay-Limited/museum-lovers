import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:museumLovers/config/app_config.dart';
import 'package:museumLovers/config/more_apps.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/util/consent_manager.dart';
import 'package:open_store/open_store.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Future<void> _shareApp() => SharePlus.instance.share(
        ShareParams(
          text: 'Check out $appName — explore masterpieces from the Rijksmuseum collection.\n'
              '${AppConfig.appStoreUrl}',
        ),
      );

  Future<void> _rateApp() => InAppReview.instance.openStoreListing(appStoreId: AppConfig.museumLoversAppStoreId);

  Future<void> _watchAdFreeAd(BuildContext context) async {
    final AppStore store = context.appStore;
    await RewardedAdManager.showForAdFreeDay(
      onRewarded: () {
        store.grantAdFree(const Duration(hours: 24));
        Fluttertoast.showToast(msg: 'Ads switched off for 24 hours. Enjoy!');
      },
      onUnavailable: () => Fluttertoast.showToast(msg: 'No ad is ready right now — try again in a moment.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppStore store = context.appStore;
    return Scaffold(
        backgroundColor: const Color(0xff141213),
        appBar: AppBar(
          backgroundColor: const Color(0xff141213),
          title: const Text('Settings'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.ios_share),
              title: const Text('Share this app'),
              onTap: _shareApp,
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Rate this app'),
              onTap: _rateApp,
            ),
            ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: const Text('Remove ads for 24 hours'),
              subtitle: Text(
                store.isAdFree ? 'Ad-free until ${store.adFreeUntil!.toLocal().hour}:00' : 'Watch a short video',
              ),
              enabled: !store.isAdFree,
              onTap: () => _watchAdFreeAd(context),
            ),
            FutureBuilder<bool>(
              future: ConsentManager.isPrivacyOptionsRequired,
              builder: (context, snapshot) {
                if (snapshot.data != true) return const SizedBox.shrink();
                return ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy options'),
                  onTap: ConsentManager.showPrivacyOptionsForm,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'More apps',
                style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600),
              ),
            ),
            for (final MoreApp app in moreApps) _MoreAppTile(app: app),
            const SizedBox(height: 24),
          ],
        ),
      );
  }
}

class _MoreAppTile extends StatelessWidget {
  const _MoreAppTile({Key? key, required this.app}) : super(key: key);

  final MoreApp app;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(app.iconAsset, width: 44, height: 44, fit: BoxFit.cover),
        ),
        title: Text(app.name),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => OpenStore.instance.open(
          appStoreId: app.iosAppStoreId,
          androidAppBundleId: app.androidPackageName ?? '',
        ),
      );
}
