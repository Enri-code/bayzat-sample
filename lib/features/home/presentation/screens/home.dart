import 'package:bayzat_test/core/helpers/event_status.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon_details.dart';
import 'package:bayzat_test/features/home/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:bayzat_test/features/home/presentation/bloc/pokemons/pokemons_bloc.dart';
import 'package:bayzat_test/features/home/presentation/screens/details.dart';
import 'package:flutter/material.dart';

import 'package:bayzat_test/app/theme/colors.dart';
import 'package:bayzat_test/features/home/presentation/widgets/app_bar.dart';
import 'package:bayzat_test/features/home/presentation/widgets/pokemon_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: TabBar(
              indicatorWeight: 4,
              onTap: (value) => setState(() => tabIndex = value),
              tabs: [
                const Tab(text: 'All Pokemons', height: 34),
                Tab(
                  height: 34,
                  child: BlocBuilder<FavouritesBloc, FavouritesState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Text('Favourites'),
                          ),
                          if (state.pokemons.isNotEmpty)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  state.pokemons.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Colors.grey[200]!,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: _ViewBody(tabIndex),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewBody extends StatefulWidget {
  const _ViewBody(this.tabIndex);

  final int tabIndex;

  @override
  State<_ViewBody> createState() => _ViewBodyState();
}

class _ViewBodyState extends State<_ViewBody> {
  final _gridKey = GlobalKey();

  @override
  void initState() {
    context.read<PokemonsBloc>().add(GetPokemons());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemons = widget.tabIndex == 0
        ? context.watch<PokemonsBloc>().state.pokemons
        : context.watch<FavouritesBloc>().state.pokemons;

    return Column(
      children: [
        ReorderableBuilder(
          enableDraggable: false,
          enableLongPress: false,
          enableScrollingWhileDragging: false,
          children: List.generate(
            pokemons.length,
            (index) {
              final colIndex = (pokemons[index].id / 3).floor() % 3;
              final bgColor = ColorPalette.cardColors[colIndex];
              return PokemonCard(
                pokemons[index],
                backgroundColor: bgColor,
                key: Key(pokemons[index].idHash),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    DetailsScreen.routeName,
                    arguments: PokemonDetails(pokemons[index], bgColor),
                  );
                },
              );
            },
          ),
          builder: (children) {
            return GridView(
              key: _gridKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              children: children,
            );
          },
        ),
        if (widget.tabIndex == 0)
          _PokemonsQueryWidgets(pokemons: pokemons)
        else if (widget.tabIndex == 1 && pokemons.isEmpty)
          Text(
            'You have not favourited any pokemons yet!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
      ],
    );
  }
}

class _PokemonsQueryWidgets extends StatelessWidget {
  const _PokemonsQueryWidgets({required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    final pokemonsState = context.watch<PokemonsBloc>().state;
    return Column(
      children: [
        if (pokemonsState.status == EventStatus.loading)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          )
        else
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                context.read<PokemonsBloc>().add(GetPokemons());
              },
              child: Builder(builder: (context) {
                if (pokemons.isEmpty) {
                  return const Text('Get Pokemons');
                } else if (pokemonsState.status == EventStatus.error) {
                  return const Text('Retry');
                } else {
                  return const Text('Fetch More');
                }
              }),
            ),
          ),
      ],
    );
  }
}
