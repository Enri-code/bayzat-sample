import 'package:hive_flutter/hive_flutter.dart';

import 'package:bayzat_test/app.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}
