import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/poke_store.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/domain/use_cases/favourite_pokemon.dart';
import 'package:bayzat_test/features/home/domain/use_cases/get_saved_pokemons.dart';
import 'package:bayzat_test/features/home/domain/use_cases/unfavourite_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({
    required this.store,
    required this.repo,
  }) : super(const FavouritesState()) {
    on<GetFavourites>(_init);
    on<FavouritePokemon>(_favourite);
    on<UnfavouritePokemon>(_unfavourite);
  }

  final IPokemonsRepo repo;
  final Store<Pokemon> store;

  Future _init(GetFavourites event, Emitter<FavouritesState> emit) async {
    emit(state.copyWith(pokemons: await store.getAll()));

    final pokemons = await GetStoredPokemonsCase(repo, store: store).call();

    pokemons.fold((l) => null, (r) => emit(state.copyWith(pokemons: r)));
  }

  void _favourite(FavouritePokemon event, Emitter<FavouritesState> emit) {
    if (state.contains(event.pokemon)) return;

    FavouritePokemonCase(store, pokemon: event.pokemon).call();

    final newlist = List<Pokemon>.from(state.pokemons);
    newlist.add(event.pokemon);

    emit(state.copyWith(pokemons: newlist));
  }

  void _unfavourite(UnfavouritePokemon event, Emitter<FavouritesState> emit) {
    if (!state.contains(event.pokemon)) return;

    UnfavouritePokemonCase(store, pokemon: event.pokemon).call();

    final newlist = List<Pokemon>.from(state.pokemons);
    newlist.removeWhere((e) => e.id == event.pokemon.id);

    emit(state.copyWith(pokemons: newlist));
  }
}
