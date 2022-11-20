import 'package:hive_flutter/hive_flutter.dart';

import 'package:bayzat_test/app.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  //.whenComplete(() => FlutterNativeSplash.remove());
  runApp(const MyApp());
}
