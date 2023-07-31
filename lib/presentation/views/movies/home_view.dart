import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/bloc/movie_now_playing/movie_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_popular/popular_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_upcoming/upcoming_bloc.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _loadNextPage(context);
    _loadNextPagePopular(context);
    _loadNextPageUpcoming(context);
  }

  void _loadNextPage(BuildContext context) {
    context.read<MovieBloc>().add(const LoadNextPageEvent());
  }

  void _loadNextPagePopular(BuildContext context) {
    context.read<PopularBloc>().add(const LoadNextPagePopularEvent());
  }

  void _loadNextPageUpcoming(BuildContext context) {
    context.read<UpcomingBloc>().add(const LoadNextPageUpcomingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                BlocSelector<MovieBloc, MovieState, List<Movie>>(
                  selector: (state) => state.movies,
                  builder: (context, movies) {
                    return movies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : MoviesSlideshow(movies: movies.sublist(0, 6));
                  },
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    return state.movies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : MovieHorizontalListview(
                            movies: state.movies,
                            title: 'En cines',
                            subTitle: 'lunes 20',
                            loadNextPage: () {
                              print('movies builder');
                              _loadNextPage(context);
                            },
                          );
                  },
                ),
                BlocSelector<MovieBloc, MovieState, List<Movie>>(
                  selector: (state) => state.movies,
                  builder: (context, movies) {
                    return movies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : MovieHorizontalListview(
                            movies: movies,
                            title: 'En cines',
                            subTitle: 'lunes 20',
                            loadNextPage: () {
                              print('movies');
                              _loadNextPage(context);
                            },
                          );
                  },
                ),
                BlocSelector<UpcomingBloc, UpcomingState, List<Movie>>(
                  selector: (state) => state.movies,
                  builder: (context, movies) {
                    return movies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : MovieHorizontalListview(
                            movies: movies,
                            title: 'Proximamente',
                            subTitle: 'lunes 120',
                            loadNextPage: () {
                              print('upcoming');
                              _loadNextPageUpcoming(context);
                            },
                          );
                  },
                ),
                BlocSelector<PopularBloc, PopularState, List<Movie>>(
                  selector: (state) => state.movies,
                  builder: (context, movies) {
                    return movies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : MovieHorizontalListview(
                            movies: movies,
                            title: 'Popular movies',
                            subTitle: 'lunes 220',
                            loadNextPage: () {
                              print('popular');
                              _loadNextPagePopular(context);
                            },
                          );
                  },
                ),
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }
}
