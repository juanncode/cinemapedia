import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actos_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  final ActorsDatasource actorsDatasource;

  ActorRepositoryImpl(this.actorsDatasource);
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}
