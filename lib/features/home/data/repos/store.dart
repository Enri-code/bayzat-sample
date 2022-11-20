import 'package:bayzat_test/features/home/data/models/pokemon.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HivePokeStore extends Store<Pokemon> {
  Box? _store;

  Future<Box>? _initFuture;

  Future _init() async {
    await _initFuture;
    _store ??= await (_initFuture = Hive.openBox('favourites'));
  }

  @override
  Future<List> get getKeys async {
    await _init();
    return _store!.keys.toList();
  }

  @override
  Future add(Pokemon pokemon) async {
    await _init();
    return _store!.put(pokemon.id, PokemonModel.convertToMap(pokemon));
  }

  @override
  Future remove(Pokemon pokemon) async {
    await _init();
    return _store!.delete(pokemon.id);
  }

  @override
  Future<List<Pokemon>> getAll() async {
    await _init();
    return _store!.values.map((e) {
      return PokemonModel.fromMap(Map.from(e));
    }).toList();
  }
}
