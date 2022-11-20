import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';
import 'package:bayzat_test/features/home/domain/use_cases/favourite_pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favourite_pokemon_test.mocks.dart';

@GenerateMocks([Store])
void main() {
  late Pokemon pokemon;
  late FavouritePokemonCase usecase;
  late MockStore<Pokemon> mockStore;

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
    mockStore = MockStore<Pokemon>();
    usecase = FavouritePokemonCase(mockStore, pokemon: pokemon);
  });

  test(
    'should favourite the pokemon and add to the store',
    () async {
      verifyZeroInteractions(mockStore);

      //When [FavouritePokemonCase] is called, it should return the [Right] of
      //the Either argument.
      when(mockStore.add(pokemon)).thenAnswer((_) async => null);

      ///Call the usecase function
      final result = await usecase();

      // Usecase should return what was returned from the repo
      expect(result, isNull);

      // Verify that the function was called on the repo
      verify(mockStore.add(pokemon)).called(1);

      // Verify no other method was called on the repo.
      verifyNoMoreInteractions(mockStore);
    },
  );
}
