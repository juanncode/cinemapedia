import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/bloc/actors/actors_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_cache/movie_cache_cubit.dart';
import 'package:cinemapedia/presentation/screens/movies/actor_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCacheCubit>().getMovieDetail(widget.movieId);
    context.read<ActorsBloc>().add(LoadActorsEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCacheCubit, MovieCacheState>(
      builder: (context, state) {
        final movieDetail = state.movieCache[widget.movieId];
        if (movieDetail == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              _CustomSliverAppBar(movie: movieDetail),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movieDetail),
                  childCount: 1,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (e) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            ],
          ),
        ),
        ActorMovie(movieId: movie.id.toString()),
        const SizedBox(height: 100)
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const SizedBox();
                  }
                  return FadeIn(
                    duration: const Duration(milliseconds: 700),
                    child: child,
                  );
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7, 1.0]),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent], begin: Alignment.topLeft, stops: [0.0, 0.3]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
