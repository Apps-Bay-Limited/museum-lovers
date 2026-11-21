import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:museumLovers/config/app_config.dart';
import 'package:museumLovers/store/app_store.dart';

/// Sells and restores the one-time "Premium" unlock and mirrors ownership into
/// [AppStore.isPremium], which is what the rest of the app checks.
class PremiumService extends ChangeNotifier {
  PremiumService(this._store, {InAppPurchase? iap}) : _iap = iap ?? InAppPurchase.instance;

  final AppStore _store;
  final InAppPurchase _iap;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  Completer<bool>? _restoreCompleter;

  ProductDetails? _product;
  bool _isBusy = false;
  String? _error;

  /// Null until the store has returned the product (and always null where
  /// billing is unavailable, e.g. emulators without Play services).
  ProductDetails? get product => _product;
  bool get isBusy => _isBusy;
  String? get error => _error;

  Future<void> init() async {
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdates,
      onError: (Object error) => _fail('Purchase failed: $error'),
    );
    try {
      await _loadProduct();
      // Play's restore is silent, so it doubles as a startup sync after a
      // reinstall. On iOS, restoring can prompt for an Apple ID, so it only
      // happens when the user taps "Restore purchase".
      if (_product != null && defaultTargetPlatform == TargetPlatform.android) {
        await _iap.restorePurchases();
      }
    } catch (error) {
      debugPrint('PremiumService init failed: $error');
    }
  }

  Future<void> _loadProduct() async {
    if (!await _iap.isAvailable()) {
      return;
    }
    final ProductDetailsResponse response = await _iap.queryProductDetails(<String>{AppConfig.premiumProductId});
    _product = response.productDetails.firstWhereOrNull((ProductDetails p) => p.id == AppConfig.premiumProductId);
    notifyListeners();
  }

  Future<void> buy() async {
    if (_isBusy) {
      return;
    }
    _error = null;
    _setBusy(true);
    try {
      if (_product == null) {
        await _loadProduct();
      }
      final ProductDetails? product = _product;
      if (product == null) {
        _fail('The store is unavailable right now. Please try again later.');
        return;
      }
      final bool started = await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: product));
      if (!started) {
        _setBusy(false);
      }
    } catch (error) {
      _fail('Purchase failed: $error');
    }
  }

  /// Completes with whether Premium is owned once the store has replayed past
  /// purchases. Stores don't signal "nothing to restore", hence the timeout.
  Future<bool> restore() async {
    if (_isBusy) {
      return _store.isPremium;
    }
    _error = null;
    _setBusy(true);
    final Completer<bool> completer = _restoreCompleter = Completer<bool>();
    try {
      await _iap.restorePurchases();
      return await completer.future.timeout(const Duration(seconds: 4), onTimeout: () => _store.isPremium);
    } catch (error) {
      _fail('Restore failed: $error');
      return _store.isPremium;
    } finally {
      _restoreCompleter = null;
      _setBusy(false);
    }
  }

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final PurchaseDetails purchase in purchases) {
      if (purchase.productID == AppConfig.premiumProductId) {
        switch (purchase.status) {
          case PurchaseStatus.pending:
            _setBusy(true);
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            _store.setPremium(true);
            _error = null;
            final Completer<bool>? completer = _restoreCompleter;
            if (completer != null && !completer.isCompleted) {
              completer.complete(true);
            }
            _setBusy(false);
          case PurchaseStatus.error:
            _fail(purchase.error?.message ?? 'Purchase failed.');
          case PurchaseStatus.canceled:
            _setBusy(false);
        }
      }
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  void _fail(String message) {
    _error = message;
    _setBusy(false);
  }

  void _setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
