import 'package:bayzat_test/core/helpers/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "should convert a number to a string prefixed with '#' and leading '0's",
    () {
      expect(convertToIdHash(526), '#526');

      expect(convertToIdHash(43), '#043');

      expect(() => convertToIdHash(-4), throwsAssertionError);
    },
  );
}
