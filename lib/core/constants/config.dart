import 'package:bayzat_test/features/home/presentation/screens/details.dart';
import 'package:bayzat_test/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';

///Global class containing const variables for the application
/// used across the project
abstract class AppConfig {
  AppConfig._();

  ///The one-line description used to represent the app (Android and Web)
  static const appName = 'Pokedex';

  ///Routes configuration map to be used in pushNamed and etc
  static final appRoutes = <String, WidgetBuilder>{
    HomeScreen.routeName: (_) => const HomeScreen(),
    DetailsScreen.routeName: (_) => const DetailsScreen(),
  };
}
