import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The app's palette. Screens read colors from here (or the [ThemeData]
/// built from it) rather than hardcoding hex values.
class AppColors {
  AppColors._();

  static const Color background = Color(0xff141213);
  static const Color surface = Color(0xff1e1b1d);
  static const Color surfaceHigh = Color(0xff2a2628);
  static const Color accent = Color(0xffD2FCAC);
  static const Color onAccent = Color(0xff141213);
  static const Color textPrimary = Color(0xfff5f2f3);
  static const Color textSecondary = Color(0xa6ffffff);
  static const Color textTertiary = Color(0x66ffffff);
  static const Color hairline = Color(0x1fffffff);
  static const Color scrim = Color(0x8c000000);
}

/// Serif face for "wall label" moments (artwork titles, the paywall). Georgia
/// ships with iOS; Android resolves the generic serif family instead.
TextStyle displayStyle(double size, {FontWeight weight = FontWeight.w600, Color color = AppColors.textPrimary}) =>
    TextStyle(
      fontFamily: 'Georgia',
      fontFamilyFallback: const <String>['serif'],
      fontSize: size,
      fontWeight: weight,
      height: 1.2,
      letterSpacing: -0.2,
      color: color,
    );

ThemeData buildAppTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(seedColor: AppColors.accent, brightness: Brightness.dark).copyWith(
    primary: AppColors.accent,
    onPrimary: AppColors.onAccent,
    secondary: AppColors.accent,
    onSecondary: AppColors.onAccent,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    surfaceContainerLowest: AppColors.background,
    surfaceContainerLow: AppColors.surface,
    surfaceContainer: AppColors.surface,
    surfaceContainerHigh: AppColors.surfaceHigh,
    surfaceContainerHighest: AppColors.surfaceHigh,
    outline: Colors.white24,
    outlineVariant: AppColors.hairline,
  );
  final ThemeData base = ThemeData(useMaterial3: true, brightness: Brightness.dark, colorScheme: scheme);
  final TextTheme text =
      _tightened(base.textTheme).apply(bodyColor: AppColors.textPrimary, displayColor: AppColors.textPrimary);
  final RoundedRectangleBorder rounded14 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.background,
    textTheme: text,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 62,
      indicatorColor: AppColors.accent.withValues(alpha: 0.16),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        final bool selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 11,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          color: selected ? AppColors.accent : AppColors.textSecondary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected) ? AppColors.accent : AppColors.textSecondary,
          )),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textTertiary,
      indicatorColor: AppColors.accent,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: AppColors.hairline,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        minimumSize: const Size(0, 48),
        shape: rounded14,
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accent,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: Colors.white24),
        minimumSize: const Size(0, 44),
        shape: rounded14,
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.hairline, thickness: 0.5, space: 1),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.textSecondary,
      textColor: AppColors.textPrimary,
      titleTextStyle: text.bodyLarge?.copyWith(fontSize: 16),
      subtitleTextStyle: text.bodySmall?.copyWith(fontSize: 13, color: AppColors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      dragHandleColor: Colors.white24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surfaceHigh,
      surfaceTintColor: Colors.transparent,
      shape: rounded14,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.accent),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => states.contains(WidgetState.selected) ? AppColors.accent : null,
      ),
      checkColor: const WidgetStatePropertyAll<Color>(AppColors.onAccent),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppColors.surfaceHigh,
      side: BorderSide.none,
      shape: StadiumBorder(),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surfaceHigh,
      contentTextStyle: TextStyle(color: AppColors.textPrimary),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: AppColors.accent),
  );
}

/// Material 3's default tracking reads airy next to the iOS system font, so
/// headings are tightened and body text set to neutral tracking.
TextTheme _tightened(TextTheme t) {
  TextStyle? track(TextStyle? style, double spacing) => style?.copyWith(letterSpacing: spacing);
  return t.copyWith(
    displayLarge: track(t.displayLarge, -0.5),
    displayMedium: track(t.displayMedium, -0.5),
    displaySmall: track(t.displaySmall, -0.4),
    headlineLarge: track(t.headlineLarge, -0.4),
    headlineMedium: track(t.headlineMedium, -0.3),
    headlineSmall: track(t.headlineSmall, -0.3),
    titleLarge: track(t.titleLarge, -0.2),
    titleMedium: track(t.titleMedium, -0.1),
    titleSmall: track(t.titleSmall, 0),
    bodyLarge: track(t.bodyLarge, 0),
    bodyMedium: track(t.bodyMedium, 0),
    bodySmall: track(t.bodySmall, 0),
    labelLarge: track(t.labelLarge, 0),
    labelMedium: track(t.labelMedium, 0.1),
    labelSmall: track(t.labelSmall, 0.2),
  );
}
