import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:museumLovers/config/app_config.dart';
import 'package:museumLovers/config/more_apps.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/screens/premium_page.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/ads_manager.dart';
import 'package:museumLovers/util/consent_manager.dart';
import 'package:museumLovers/widgets.dart';
import 'package:open_store/open_store.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 32),
        children: <Widget>[
          const _Inset(_PremiumBanner()),
          const SectionHeader('General', padding: EdgeInsets.fromLTRB(20, 24, 20, 8)),
          _Inset(_Group(
            children: <Widget>[
              _SettingsTile(icon: Icons.ios_share_rounded, title: 'Share $appName', onTap: _shareApp),
              _SettingsTile(icon: Icons.star_outline_rounded, title: 'Rate $appName', onTap: _rateApp),
              if (!store.isPremium)
                _SettingsTile(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Remove ads for 24 hours',
                  subtitle: store.hasTemporaryAdFree
                      ? 'Ad-free until ${store.adFreeUntil!.toLocal().hour}:00'
                      : 'Watch a short video',
                  onTap: store.hasTemporaryAdFree ? null : () => _watchAdFreeAd(context),
                ),
            ],
          )),
          FutureBuilder<bool>(
            future: ConsentManager.isPrivacyOptionsRequired,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data != true) {
                return const SizedBox.shrink();
              }
              return const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: _Group(
                  children: <Widget>[
                    _SettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy options',
                      onTap: ConsentManager.showPrivacyOptionsForm,
                    ),
                  ],
                ),
              );
            },
          ),
          const SectionHeader('More apps by us', padding: EdgeInsets.fromLTRB(20, 24, 20, 10)),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: moreApps.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 14),
              itemBuilder: (BuildContext context, int index) => _MoreAppTile(app: moreApps[index]),
            ),
          ),
          const SizedBox(height: 28),
          const _Inset(
            Text(
              'Artwork images and data courtesy of the Rijksmuseum, Amsterdam.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  const _PremiumBanner();

  @override
  Widget build(BuildContext context) {
    final bool isPremium = context.appStore.isPremium;
    final String? price = context.premium.product?.price;
    return Material(
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      color: AppColors.surface,
      child: InkWell(
        onTap: () => PremiumPage.open(context),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[AppColors.accent.withValues(alpha: 0.22), AppColors.accent.withValues(alpha: 0.04)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                child: Icon(isPremium ? Icons.check_rounded : Icons.workspace_premium_rounded,
                    color: AppColors.onAccent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(isPremium ? 'Premium is active' : 'Go Premium', style: displayStyle(19)),
                    const SizedBox(height: 3),
                    Text(
                      isPremium ? 'Thank you for supporting the app!' : 'No ads · Boards · Postcards',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              if (!isPremium)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: const ShapeDecoration(color: AppColors.accent, shape: StadiumBorder()),
                  child: Text(
                    price ?? 'Upgrade',
                    style: const TextStyle(color: AppColors.onAccent, fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                )
              else
                const Icon(Icons.chevron_right, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Inset extends StatelessWidget {
  const _Inset(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: child);
}

/// A rounded card of tiles separated by inset hairlines, iOS-settings style.
class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SurfaceCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            for (int i = 0; i < children.length; i++) ...<Widget>[
              if (i > 0) const Divider(indent: 60, height: 1),
              children[i],
            ],
          ],
        ),
      );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(9)),
              child: Icon(icon, size: 18, color: enabled ? AppColors.textPrimary : AppColors.textTertiary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(subtitle!, style: const TextStyle(fontSize: 12.5, color: AppColors.textTertiary)),
                    ),
                ],
              ),
            ),
            if (enabled) const Icon(Icons.chevron_right, size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _MoreAppTile extends StatelessWidget {
  const _MoreAppTile({required this.app});

  final MoreApp app;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => OpenStore.instance.open(
          appStoreId: app.iosAppStoreId,
          androidAppBundleId: app.androidPackageName ?? '',
        ),
        child: SizedBox(
          width: 64,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(app.iconAsset, width: 58, height: 58, fit: BoxFit.cover),
              ),
              const SizedBox(height: 6),
              Text(
                app.name.split(':').first,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, height: 1.2, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
}
