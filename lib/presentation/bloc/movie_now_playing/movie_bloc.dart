import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepository moviesRepository;

  MovieBloc(this.moviesRepository) : super(const MovieState()) {
    on<LoadNextPageEvent>(_onLoadNextPage);
  }

  void _onLoadNextPage(
    LoadNextPageEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (state.isLoadingMovies) return;
    emit(state.copyWith(isLoadingMovies: true));
    final response = await moviesRepository.getNowPlaying(page: state.currentPage + 1);
    final newMovies = [...state.movies, ...response];
    print('length movies ${newMovies.length}');

    emit(state.copyWith(
        isLoadingMovies: false, isLoading: false, movies: newMovies, currentPage: state.currentPage + 1));
  }
}
