/// Cross-promotion directory of sibling apps by the same developer, shown on
/// the Settings screen's "More apps" section.
class MoreApp {
  const MoreApp({
    required this.name,
    required this.iconAsset,
    required this.iosAppStoreId,
    this.androidPackageName,
  });

  final String name;
  final String iconAsset;
  final String iosAppStoreId;
  final String? androidPackageName;
}

const List<MoreApp> moreApps = <MoreApp>[
  MoreApp(name: 'Music Box', iconAsset: 'assets/app_icons/classical_music_box.png', iosAppStoreId: ''),
  MoreApp(name: 'TripMark', iconAsset: 'assets/app_icons/tripmark.png', iosAppStoreId: '6464474080'),
  MoreApp(
    name: 'SwiftSum',
    iconAsset: 'assets/app_icons/simple_calculator.png',
    iosAppStoreId: '1610829871',
    androidPackageName: 'com.appsbay.simple_calculator',
  ),
  MoreApp(
    name: 'Relaxing Up: Meditation & Healing',
    iconAsset: 'assets/app_icons/relaxing_up.png',
    iosAppStoreId: '1618712178',
    androidPackageName: 'com.appsbay.relaxing_up',
  ),
  MoreApp(
    name: 'Metronome Go',
    iconAsset: 'assets/app_icons/metronome_go.png',
    iosAppStoreId: '1635462172',
    androidPackageName: 'com.appsbay.metronome_go',
  ),
  MoreApp(
    name: 'Shows',
    iconAsset: 'assets/app_icons/shows.png',
    iosAppStoreId: '1624910011',
    androidPackageName: 'com.appsbay.shows',
  ),
  MoreApp(name: 'Yes Habit', iconAsset: 'assets/app_icons/yes_habit.png', iosAppStoreId: '1637643734'),
  MoreApp(
    name: 'We Play Piano',
    iconAsset: 'assets/app_icons/we_play_piano.png',
    iosAppStoreId: '1625018611',
    androidPackageName: 'com.appsbay.we_play_piano',
  ),
  MoreApp(
    name: 'World Weather Live',
    iconAsset: 'assets/app_icons/world_weather_live.png',
    iosAppStoreId: '1612773646',
    androidPackageName: 'com.appsbay.world_weather_live',
  ),
  MoreApp(
    name: 'Chess Room',
    iconAsset: 'assets/app_icons/chess_room.png',
    iosAppStoreId: '1642306743',
    androidPackageName: 'com.appsbay.chess_room',
  ),
  MoreApp(
    name: 'Sudoku Lover',
    iconAsset: 'assets/app_icons/sudoku_lover.png',
    iosAppStoreId: '1620749798',
    androidPackageName: 'com.appsbay.sudoku_lovers',
  ),
  MoreApp(
    name: 'Onlynote',
    iconAsset: 'assets/app_icons/onlynote.png',
    iosAppStoreId: '1616516732',
    androidPackageName: 'com.appsbay.onlynote',
  ),
  MoreApp(name: 'Money Tracker', iconAsset: 'assets/app_icons/money_tracker.png', iosAppStoreId: '1534244892'),
  MoreApp(name: 'Easy Unit', iconAsset: 'assets/app_icons/easy_unit.png', iosAppStoreId: '1643640909'),
];
