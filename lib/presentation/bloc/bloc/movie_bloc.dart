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
    final response = await moviesRepository.getNowPlaying(page: event.currentPage);
    emit(state.copyWith(isLoading: false, movies: [...state.movies, ...response]));
  }
}
