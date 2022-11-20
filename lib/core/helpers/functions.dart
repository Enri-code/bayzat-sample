import 'package:bayzat_test/features/home/domain/entities/stats.dart';

String convertToIdHash(num id) {
  assert(id >= 0, 'ID should be greater than or equal to 0');
  return "#${'$id'.padLeft(3, '0')}";
}

///Formula is [weight] / ([height] ^ 2)
String calculateBMI({required num height, required num weight}) {
  return (weight / (height * height)).toStringAsFixed(2);
}

calculateAvgPower(List<Stat> stats) {
  if (stats.isEmpty) return 0;
  //Combines the sum of all the stats values
  final totalStats = stats.fold(0, (prev, val) => prev + val.value);
  //Finds the average of the stats and rounds up into an integer
  return (totalStats / stats.length).round();
}
