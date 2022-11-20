import 'package:bayzat_test/core/helpers/functions.dart';
import 'package:bayzat_test/features/home/domain/entities/stats.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final num height, weight;
  final List<String> types;
  final List<Stat> stats;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  ///Returns pokemon's id padded with '0' and prefixed with '#'
  String get idHash => convertToIdHash(id);

  ///A person's BMI is their weight in KG, divided by the square of their height
  String get bmi => calculateBMI(height: height, weight: weight);

  String get formattedTypes => types.join(', ');

  List<Stat> get allStats => [
        ...stats,
        Stat(title: 'Avg. Power', value: calculateAvgPower(stats)),
      ];

  @override
  operator ==(Object other) => other is Pokemon && other.id == id;

  @override
  int get hashCode => id.hashCode | runtimeType.hashCode;
}
