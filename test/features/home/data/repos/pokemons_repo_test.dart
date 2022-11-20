import 'package:bayzat_test/core/constants/server_config.dart';
import 'package:bayzat_test/core/utils/api_client.dart';
import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/features/home/data/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemons_repo_test.mocks.dart';

///Function to be mocked as pokemon converter
abstract class Converter {
  Pokemon call(Map<String, dynamic>? map);
}

@GenerateMocks([ApiClient, Converter])
void main() {
  //Amount of pokemons to be returned from repository
  const pokemonCount = 15;

  late Pokemon pokemon;

  //Response gotten from [MockApiClient]
  late Map<String, dynamic> pokemonsResponseMap;

  late PokemonsRepoImpl repo;
  late MockApiClient mockApi;
  late MockConverter converter;

  setUp(() {
    pokemon = const Pokemon(
      id: 0,
      name: 'name',
      imageUrl: 'imageUrl',
      height: 8,
      weight: 20,
      stats: [],
      types: [],
    );
    pokemonsResponseMap = {
      'results': List.generate(pokemonCount, (index) => {'url': 'get_pokemon'}),
    };
    mockApi = MockApiClient();
    converter = MockConverter();
    repo = PokemonsRepoImpl(mockApi, converter: converter);
  });

  test(
    'Returns Map from ApiCLient and return Pokemon from converter for each element',
    () async {
      //Verify that the mocks have not been interacted with yet
      verifyZeroInteractions(mockApi);
      verifyZeroInteractions(converter);

      when(mockApi.get(
        ServerConfig.pokemonsPath,
        parameters: anyNamed('parameters'),
      )).thenAnswer((_) async {
        return ApiData<Map<String, dynamic>>(pokemonsResponseMap, 200);
      });

      when(mockApi.get('get_pokemon')).thenAnswer(
        (_) async => const ApiData<Map<String, dynamic>>({}, 200),
      );

      when(converter(any)).thenReturn(pokemon);

      //Call the repository function
      final result = await repo.getPokemons();

      // Repo should return what was returned from the repo
      expect(result.isRight(), isTrue);

      //Retrieve the data from the result of the function called above
      final data = (result as Right<AppError, List<Pokemon>>).value;
      expect(data.length, equals(pokemonCount));
      expect(data.every((e) => e == pokemon), isTrue);

      // Verify that the functions were called on the mocks
      verify(mockApi.get(
        ServerConfig.pokemonsPath,
        parameters: anyNamed('parameters'),
      )).called(1);

      verify(mockApi.get('get_pokemon')).called(pokemonCount);
      verify(converter.call(any)).called(pokemonCount);

      // Verify no other interactions on the mocks.
      verifyNoMoreInteractions(mockApi);
      verifyNoMoreInteractions(converter);
    },
  );
}
