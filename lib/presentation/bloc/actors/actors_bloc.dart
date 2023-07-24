import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'actors_event.dart';
part 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  final ActorRepository actorRepository;
  ActorsBloc(this.actorRepository) : super(const ActorsState()) {
    on<LoadActorsEvent>(_onLoadActors);
  }

  void _onLoadActors(
    LoadActorsEvent event,
    Emitter<ActorsState> emit,
  ) async {
    if (state.actorCache[event.movieId] != null) return;
    final response = await actorRepository.getActorsByMovie(event.movieId);
    final actors = {...state.actorCache, event.movieId: response};

    emit(state.copyWith(actorCache: actors));
  }
}
