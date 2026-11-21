import 'package:flutter/material.dart';
import 'package:museumLovers/store/app_store.dart';
import 'package:museumLovers/util/premium_service.dart';

import 'constants.dart';
import 'domain.dart';
import 'provider.dart';
import 'screens.dart';
import 'theme.dart';

class App extends StatefulWidget {
  const App({Key? key, required this.repository, required this.store, required this.premium, this.home})
      : super(key: key);

  final RijksRepository repository;
  final AppStore store;
  final PremiumService premium;
  final Widget? home;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => RepositoryProvider(
        repository: widget.repository,
        child: AppStoreProvider(
          store: widget.store,
          child: PremiumProvider(
            premium: widget.premium,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: buildAppTheme(),
              home: widget.home ?? const MainNavigationPage(),
            ),
          ),
        ),
      );
}
