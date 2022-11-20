import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/entities/stats.dart';

class PokemonModel extends Pokemon {
  PokemonModel._({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.height,
    required super.weight,
    required super.types,
    required super.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> map) {
    final types = (map['types'] as List).map<String>((e) {
      return e['type']['name'];
    }).toList();

    final stats = (map['stats'] as List).map((e) {
      return Stat(title: e['stat']['name'], value: e['base_stat']);
    }).toList();

    return PokemonModel._(
      id: map['id'],
      name: map['name'],
      imageUrl: map['sprites']['front_default'],
      height: map['height'],
      weight: map['weight'],
      types: types,
      stats: stats,
    );
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final stats = (map['stats'] as List).map((e) {
      return Stat(title: e['title'], value: e['value']);
    }).toList();

    return PokemonModel._(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      height: map['height'],
      weight: map['weight'],
      types: map['types'],
      stats: stats,
    );
  }

  static Map<String, dynamic> convertToMap(Pokemon pokemon) {
    return {
      'id': pokemon.id,
      'name': pokemon.name,
      'imageUrl': pokemon.imageUrl,
      'height': pokemon.height,
      'weight': pokemon.weight,
      'types': pokemon.types,
      'stats': pokemon.stats
          .map((e) => {'title': e.title, 'value': e.value})
          .toList(),
    };
  }
}
