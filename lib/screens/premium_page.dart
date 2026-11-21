import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/premium_service.dart';

/// Returns true if the user owns Premium; otherwise opens the paywall and
/// returns whether they bought (or restored) it there.
Future<bool> ensurePremium(BuildContext context) async {
  final AppStore store = AppStoreProvider.read(context);
  if (store.isPremium) {
    return true;
  }
  await PremiumPage.open(context);
  return store.isPremium;
}

class _Benefit {
  const _Benefit(this.icon, this.title, this.subtitle);

  final IconData icon;
  final String title;
  final String subtitle;
}

const List<_Benefit> _benefits = <_Benefit>[
  _Benefit(Icons.block_rounded, 'No ads, ever', 'Browse the collection without interruptions'),
  _Benefit(Icons.dashboard_outlined, 'Boards', 'Organize favorites into themed collections'),
  _Benefit(Icons.mail_outline_rounded, 'Postcards', 'Share artworks as beautiful framed postcards'),
  _Benefit(Icons.slideshow_rounded, 'Slideshow autoplay', 'Sit back while your favorites play'),
  _Benefit(Icons.extension_outlined, 'Favorites quiz', 'Test your eye on the art you love'),
];

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  static Future<void> open(BuildContext context) => Navigator.push<void>(
        context,
        MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => const PremiumPage()),
      );

  Future<void> _restore(PremiumService premium) async {
    final bool restored = await premium.restore();
    await Fluttertoast.showToast(msg: restored ? 'Premium restored. Welcome back!' : 'No previous purchase found.');
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = context.appStore.isPremium;
    final PremiumService premium = context.premium;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Soft accent glow behind the header.
          Positioned(
            top: -160,
            left: -80,
            right: -80,
            height: 460,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: <Color>[AppColors.accent.withValues(alpha: 0.20), AppColors.accent.withValues(alpha: 0)],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    child: IconButton(
                      tooltip: 'Close',
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.accent,
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: AppColors.accent.withValues(alpha: 0.35), blurRadius: 32),
                            ],
                          ),
                          child: const Icon(Icons.workspace_premium_rounded, size: 40, color: AppColors.onAccent),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('$appName\nPremium', textAlign: TextAlign.center, style: displayStyle(30)),
                      const SizedBox(height: 8),
                      const Text(
                        'One purchase. Yours forever.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Column(
                          children: <Widget>[
                            for (int i = 0; i < _benefits.length; i++) ...<Widget>[
                              if (i > 0) const Divider(indent: 52, height: 1),
                              _BenefitRow(benefit: _benefits[i]),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: isPremium ? const _ActiveCard() : _PurchaseControls(premium: premium, onRestore: _restore),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.benefit});

  final _Benefit benefit;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(benefit.icon, size: 19, color: AppColors.accent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(benefit.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(benefit.subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      );
}

class _PurchaseControls extends StatelessWidget {
  const _PurchaseControls({required this.premium, required this.onRestore});

  final PremiumService premium;
  final Future<void> Function(PremiumService) onRestore;

  @override
  Widget build(BuildContext context) {
    final ProductDetails? product = premium.product;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (premium.error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              premium.error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.5, color: Color(0xffff8a80)),
            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: FilledButton(
            style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            onPressed: premium.isBusy ? null : premium.buy,
            child: premium.isBusy
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.onAccent),
                  )
                : Text(
                    product == null ? 'Unlock Premium' : 'Unlock for ${product.price}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('One-time purchase · No subscription',
                style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(width: 6),
            const Text('·', style: TextStyle(color: AppColors.textTertiary)),
            TextButton(
              onPressed: premium.isBusy ? null : () => onRestore(premium),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              child: const Text('Restore'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActiveCard extends StatelessWidget {
  const _ActiveCard();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: <Widget>[
            Icon(Icons.check_circle_rounded, color: AppColors.accent),
            SizedBox(width: 12),
            Expanded(
              child: Text('Premium is active. Thank you for supporting $appName!', style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      );
}
