import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/bloc/movie_now_playing/movie_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_popular/popular_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_upcoming/upcoming_bloc.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(MovieRepositoryImpl(MovieDbDatasource())),
        ),
        BlocProvider(
          create: (context) => PopularBloc(MovieRepositoryImpl(MovieDbDatasource())),
        ),
        BlocProvider(
          create: (context) => UpcomingBloc(MovieRepositoryImpl(MovieDbDatasource())),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: const CustomBottomNavigation(),
        body: childView,
      ),
    );
  }
}
