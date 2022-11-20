part of 'pokemons_bloc.dart';

class PokemonsState extends Equatable {
  const PokemonsState({
    this.status = EventStatus.initial,
    this.pokemons = const [],
  });

  final EventStatus status;
  final List<Pokemon> pokemons;

  PokemonsState copyWoth({List<Pokemon>? pokemons, EventStatus? status}) {
    return PokemonsState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
    );
  }

  @override
  List<Object> get props => [status, pokemons];
}
