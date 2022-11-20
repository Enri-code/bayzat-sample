import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/core/utils/use_case_base.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';

class GetStoredPokemonsCase extends ApiUseCase<List<Pokemon>> {
  GetStoredPokemonsCase(this._repo, {required this.store});

  final IPokemonsRepo _repo;
  final Store store;

  @override
  ErrorOr<List<Pokemon>> call() async {
    final List<int> ids = (await store.getKeys).cast<int>();
    return _repo.getSavedPokemons(ids);
  }
}
