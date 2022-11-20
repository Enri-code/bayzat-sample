import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';

abstract class IPokemonsRepo {
  ErrorOr<List<Pokemon>> getPokemons([int offset = 0]);
  ErrorOr<List<Pokemon>> getSavedPokemons(List<int> ids);
}
