import 'package:bayzat_test/core/utils/app_error.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/domain/use_cases/get_pokemons.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemons_test.mocks.dart';

@GenerateMocks([IPokemonsRepo])
void main() {
  late GetPokemonsCase usecase;
  late MockIPokemonsRepo mockRepo;

  late List<Pokemon> pokemons;

  setUp(() {
    pokemons = List.generate(
      5,
      (index) => Pokemon(
        id: index,
        name: 'Pokemon $index',
        imageUrl: 'imageUrl',
        height: 8,
        weight: 20,
        stats: [],
        types: [],
      ),
    );
    mockRepo = MockIPokemonsRepo();
    usecase = GetPokemonsCase(mockRepo);
  });

  test(
    'should return a list of pokemons from the repository',
    () async {
      verifyZeroInteractions(mockRepo);

      //When [GetPokemonsCase] is called, it should return the [Right] of
      //the Either argument.
      when(mockRepo.getPokemons()).thenAnswer(
        (_) async => Right(pokemons),
      );

      ///Call the usecase function
      final data = await usecase();

      // Usecase should return what was returned from the repo
      expect(data, Right(pokemons));
      expect((data as Right<AppError, List<Pokemon>>).value.length, equals(5));

      // Verify that the function was called on the repo
      verify(mockRepo.getPokemons()).called(1);

      // Verify no other method was called on the repo.
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
