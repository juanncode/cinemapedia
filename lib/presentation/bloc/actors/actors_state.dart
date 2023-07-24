part of 'actors_bloc.dart';

class ActorsState extends Equatable {
  final Map<String, List<Actor>> actorCache;
  const ActorsState({this.actorCache = const {}});

  ActorsState copyWith({Map<String, List<Actor>>? actorCache}) =>
      ActorsState(actorCache: actorCache ?? this.actorCache);

  @override
  List<Object> get props => [actorCache];
}
