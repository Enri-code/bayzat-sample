import 'package:bayzat_test/core/constants/config.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/presentation/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class OnPressedMock extends Mock {
  void call();
}

void main() {
  late Pokemon pokemon;
  late OnPressedMock onPressedMock;

  setUp(() {
    onPressedMock = OnPressedMock();
    pokemon = const Pokemon(
      id: 0,
      name: 'name',
      imageUrl: 'imageUrl',
      height: 8,
      weight: 20,
      stats: [],
      types: [],
    );
  });

  Widget buildWidget(Widget widget) {
    return MaterialApp(
      routes: AppConfig.appRoutes,
      home: Scaffold(body: widget),
    );
  }

  group('Tests behaviour for pokemon card', () {
    testWidgets(
      "Displays pokemon's info",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildWidget(PokemonCard(pokemon)));
        expect(find.byKey(const ValueKey('image')), findsOneWidget);
        expect(find.text(pokemon.name), findsOneWidget);
        expect(find.text(pokemon.idHash), findsOneWidget);
        expect(find.text(pokemon.formattedTypes), findsOneWidget);
      },
    );

    testWidgets(
      "Calls onPressed when tapped",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildWidget(PokemonCard(
          pokemon,
          onPressed: onPressedMock,
        )));

        verifyZeroInteractions(onPressedMock);

        await tester.tap(find.byType(PokemonCard));
        await tester.pumpAndSettle();

        verify(onPressedMock()).called(1);
        verifyNoMoreInteractions(onPressedMock);
      },
    );
  });
}
