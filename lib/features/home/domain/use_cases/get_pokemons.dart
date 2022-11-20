import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/core/utils/use_case_base.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';

class GetPokemonsCase extends ApiUseCase<List<Pokemon>> {
  GetPokemonsCase(this._repo);

  final IPokemonsRepo _repo;

  @override
  ErrorOr<List<Pokemon>> call([int offset = 0]) => _repo.getPokemons(offset);
}
