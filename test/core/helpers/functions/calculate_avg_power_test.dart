import 'package:bayzat_test/core/helpers/functions.dart';
import 'package:bayzat_test/features/home/domain/entities/stats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "should calculate the average power of a pokemon",
    () {
      const stats = [
        Stat(title: 'title', value: 37),
        Stat(title: 'title', value: 20),
        Stat(title: 'title', value: 45),
      ];
      final result = calculateAvgPower(stats);

      expect(result, equals(34));
    },
  );
}
