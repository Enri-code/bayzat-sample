import 'package:bayzat_test/app/theme/widgets_theme.dart';
import 'package:flutter/material.dart';

///CLass that builds and provides custom theme for the application.
class LightThemeProvider {
  final WidgetsThemeInfo _widgetsTheme;

  ///Theme data to be used in MaterialApp
  late final ThemeData theme;

  LightThemeProvider(Color primaryColor)
      : _widgetsTheme = WidgetsThemeInfo(primaryColor: primaryColor) {
    theme = ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
      ),
      textTheme: _widgetsTheme.textTheme,
    ).copyWith(
      indicatorColor: primaryColor,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      tabBarTheme: _widgetsTheme.tabBarTheme,
      textButtonTheme: _widgetsTheme.textButtonTheme,
      elevatedButtonTheme: _widgetsTheme.elevatedButtonTheme,
      outlinedButtonTheme: _widgetsTheme.outlinedButtonTheme,
    );
  }
}
