import 'package:bayzat_test/app/theme/colors.dart';
import 'package:flutter/material.dart';

class WidgetsThemeInfo {
  WidgetsThemeInfo({required Color primaryColor})
      : textButtonTheme = TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primaryColor),
        ),
        outlinedButtonTheme = OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(380, 56),
            padding: const EdgeInsets.all(12),
            side: BorderSide(width: 1.5, color: primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

  final TextButtonThemeData textButtonTheme;
  final OutlinedButtonThemeData outlinedButtonTheme;

  final textTheme = Typography.blackCupertino
      .copyWith(
        bodyMedium: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
      )
      .apply(bodyColor: ColorPalette.darkPurple);

  final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(380, 56),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    ),
  );

  final tabBarTheme = TabBarTheme(
    labelColor: ColorPalette.darkPurple,
    labelPadding: const EdgeInsets.all(10),
    labelStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelColor: Colors.grey[600]!,
  );
}
