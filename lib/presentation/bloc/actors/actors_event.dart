part of 'actors_bloc.dart';

abstract class ActorsEvent extends Equatable {
  const ActorsEvent();

  @override
  List<Object> get props => [];
}

class LoadActorsEvent extends ActorsEvent {
  final String movieId;

  const LoadActorsEvent({required this.movieId});
}
