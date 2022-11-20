import 'dart:async';
import 'package:bayzat_test/core/helpers/event_status.dart';
import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/domain/use_cases/get_pokemons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc(this._repo) : super(const PokemonsState()) {
    on<GetPokemons>(_getPokemons);
  }

  final IPokemonsRepo _repo;

  int _offset = 0;

  Future _getPokemons(GetPokemons event, Emitter<PokemonsState> emit) async {
    emit(state.copyWoth(status: EventStatus.loading));

    final result = await GetPokemonsCase(_repo).call(_offset);

    result.fold(
      (l) => emit(state.copyWoth(status: EventStatus.error)),
      (r) {
        _offset += r.length;
        emit(state.copyWoth(
          status: EventStatus.success,
          //Ensures there are no duplicate pokemons
          pokemons: {...state.pokemons, ...r}.toList(),
        ));
      },
    );
  }
}
