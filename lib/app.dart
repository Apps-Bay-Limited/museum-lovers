import 'package:flutter/material.dart';
import 'package:museumLovers/store/app_store.dart';

import 'constants.dart';
import 'domain.dart';
import 'provider.dart';
import 'screens.dart';

class App extends StatefulWidget {
  const App({Key? key, required this.repository, required this.store, this.home}) : super(key: key);

  final RijksRepository repository;
  final AppStore store;
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
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData.dark(),
            home: widget.home ?? const MainNavigationPage(),
          ),
        ),
      );
}
