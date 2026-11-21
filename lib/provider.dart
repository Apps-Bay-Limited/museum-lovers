import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/util/premium_service.dart';

class RepositoryProvider extends InheritedWidget {
  const RepositoryProvider({Key? key, required Widget child, required this.repository}) : super(key: key, child: child);

  final RijksRepository repository;

  static RijksRepository of(BuildContext context) {
    final InheritedElement? element = context.getElementForInheritedWidgetOfExactType<RepositoryProvider>();
    assert(element != null, 'No RepositoryProvider found in context');
    return (element!.widget as RepositoryProvider).repository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) => repository != oldWidget.repository;
}

extension RepositoryProviderExtension on BuildContext {
  RijksRepository get repository => RepositoryProvider.of(this);
}

class AppStoreProvider extends InheritedNotifier<AppStore> {
  const AppStoreProvider({Key? key, required AppStore store, required Widget child})
      : super(key: key, notifier: store, child: child);

  /// Subscribes [context] to changes and returns the store.
  static AppStore of(BuildContext context) {
    final AppStoreProvider? provider = context.dependOnInheritedWidgetOfExactType<AppStoreProvider>();
    assert(provider != null, 'No AppStoreProvider found in context');
    return provider!.notifier!;
  }

  /// Returns the store without subscribing to changes.
  static AppStore read(BuildContext context) {
    final InheritedElement? element = context.getElementForInheritedWidgetOfExactType<AppStoreProvider>();
    assert(element != null, 'No AppStoreProvider found in context');
    return (element!.widget as AppStoreProvider).notifier!;
  }
}

extension AppStoreProviderExtension on BuildContext {
  AppStore get appStore => AppStoreProvider.of(this);
}

class PremiumProvider extends InheritedNotifier<PremiumService> {
  const PremiumProvider({Key? key, required PremiumService premium, required Widget child})
      : super(key: key, notifier: premium, child: child);

  static PremiumService of(BuildContext context) {
    final PremiumProvider? provider = context.dependOnInheritedWidgetOfExactType<PremiumProvider>();
    assert(provider != null, 'No PremiumProvider found in context');
    return provider!.notifier!;
  }
}

extension PremiumProviderExtension on BuildContext {
  PremiumService get premium => PremiumProvider.of(this);
}
