import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/use_cases/unfavourite_pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'favourite_pokemon_test.mocks.dart';

void main() {
  late UnfavouritePokemonCase usecase;
  late MockStore<Pokemon> mockStore;

  const pokemon = Pokemon(
    id: 0,
    name: 'name',
    imageUrl: 'imageUrl',
    height: 8,
    weight: 20,
    stats: [],
    types: [],
  );

  setUp(() {
    mockStore = MockStore<Pokemon>();
    usecase = UnfavouritePokemonCase(mockStore, pokemon: pokemon);
  });

  test(
    'should unfavourite the pokemon and remove from the store',
    () async {
      verifyZeroInteractions(mockStore);

      //When [UnfavouritePokemonCase] is called, it should return the [Right] of
      //the Either argument.
      when(mockStore.remove(pokemon)).thenAnswer((_) async => null);

      ///Call the usecase function
      final result = await usecase();

      // Usecase should return what was returned from the repo
      expect(result, isNull);

      // Verify that the function was called on the repo
      verify(mockStore.remove(pokemon)).called(1);

      // Verify no other method was called on the repo.
      verifyNoMoreInteractions(mockStore);
    },
  );
}
