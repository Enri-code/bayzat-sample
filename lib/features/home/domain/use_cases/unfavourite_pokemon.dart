import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';

class UnfavouritePokemonCase {
  UnfavouritePokemonCase(this._store, {required this.pokemon});

  final Store _store;
  final Pokemon pokemon;

  Future call() => _store.remove(pokemon);
}
