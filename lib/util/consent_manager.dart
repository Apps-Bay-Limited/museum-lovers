import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Wraps Google's User Messaging Platform (UMP) SDK so ads are only
/// requested after any required EEA/UK consent has been gathered.
class ConsentManager {
  ConsentManager._();

  /// Requests a consent info update and, if required, loads and shows the
  /// consent form before completing. Always completes — on failure we fall
  /// back to whatever [ConsentInformation.canRequestAds] already reports.
  static Future<void> gatherConsent() async {
    final Completer<void> completer = Completer<void>();

    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((FormError? formError) {
          if (!completer.isCompleted) completer.complete();
        });
      },
      (FormError error) {
        if (!completer.isCompleted) completer.complete();
      },
    );

    return completer.future;
  }

  /// Whether ads may currently be requested (consent obtained or not required).
  static Future<bool> get canRequestAds => ConsentInformation.instance.canRequestAds();

  /// Whether the "Privacy options" entry point must be shown to the user
  /// (per UMP policy, required whenever a consent form was shown).
  static Future<bool> get isPrivacyOptionsRequired async =>
      await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() ==
      PrivacyOptionsRequirementStatus.required;

  /// Shows the privacy options form, letting the user change their consent choice.
  static Future<void> showPrivacyOptionsForm() {
    final Completer<void> completer = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((FormError? formError) {
      if (!completer.isCompleted) completer.complete();
    });
    return completer.future;
  }
}
