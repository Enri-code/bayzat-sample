import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';

class FavouritePokemonCase {
  FavouritePokemonCase(this._store, {required this.pokemon});

  final Store _store;
  final Pokemon pokemon;

  Future call() => _store.add(pokemon);
}
