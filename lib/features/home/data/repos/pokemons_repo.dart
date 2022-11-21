import 'package:bayzat_test/core/constants/server_config.dart';
import 'package:bayzat_test/core/utils/api_client.dart';
import 'package:dartz/dartz.dart';

import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';

class PokemonsRepoImpl extends IPokemonsRepo {
  PokemonsRepoImpl(this._client, {required this.converter});

  final ApiClient _client;
  final Pokemon Function(Map<String, dynamic> map) converter;

  @override
  ErrorOr<List<Pokemon>> getPokemons([int offset = 0]) async {
    try {
      final result = await _client.get<Map>(
        ServerConfig.pokemonsPath,
        parameters: {'offset': offset, 'limit': 15},
      );

      if (result.statusCode == 200) {
        final data = (result.data['results'] as List).cast<Map>();

        final pokemonData = await Future.wait(
          data.map((e) => _client.get(e['url']).then((res) => res.data)),
        );

        return Right(
          pokemonData.cast<Map<String, dynamic>>().map(converter).toList(),
        );
      }

      return const Left(AppError());
    } catch (_) {
      return const Left(AppError());
    }
  }

  @override
  ErrorOr<List<Pokemon>> getSavedPokemons(List<int> ids) async {
    try {
      String getUrl(int id) => '${ServerConfig.pokemonsPath}/$id';

      final pokemonData = await Future.wait(
        ids.map((e) => _client.get(getUrl(e)).then((res) => res.data)),
        eagerError: true,
      );

      return Right(
        pokemonData.cast<Map<String, dynamic>>().map(converter).toList(),
      );
    } catch (_) {
      return const Left(AppError());
    }
  }
}
