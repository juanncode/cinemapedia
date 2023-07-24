import 'package:cinemapedia/presentation/bloc/actors/actors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorMovie extends StatelessWidget {
  final String movieId;
  const ActorMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final actorByMovie = context.watch<ActorsBloc>().state;
    final actors = actorByMovie.actorCache[movieId];
    if (actors == null) {
      return const CircularProgressIndicator();
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    actor.profilePath,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
