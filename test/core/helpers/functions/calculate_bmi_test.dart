import 'package:bayzat_test/core/helpers/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "should calculate the bmi of a pokemon",
    () {
      String result = calculateBMI(height: 10, weight: 15);
      expect(result, equals((15 / (10 * 10)).toString()));
    },
  );
}
