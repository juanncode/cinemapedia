import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_cache_state.dart';

class MovieCacheCubit extends Cubit<MovieCacheState> {
  final MoviesRepository moviesRepository;

  MovieCacheCubit(this.moviesRepository) : super(const MovieCacheState());

  void getMovieDetail(String movieId) async {
    if (state.movieCache[movieId] != null) return;

    final movieDetail = await moviesRepository.getMovieById(movieId);
    emit(state.copyWith(movieCache: {...state.movieCache, movieId: movieDetail}));
  }
}
