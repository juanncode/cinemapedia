import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/bloc/actors/actors_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movie_cache/movie_cache_cubit.dart';
import 'package:cinemapedia/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieCacheCubit(MovieRepositoryImpl(MovieDbDatasource()))),
        BlocProvider(
          create: (context) => ActorsBloc(ActorRepositoryImpl(ActorMoviedbDatasource())),
        ),
        BlocProvider(
          create: (context) => SearchBloc(MovieRepositoryImpl(MovieDbDatasource())),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRourter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
