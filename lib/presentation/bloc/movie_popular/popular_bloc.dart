import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final MoviesRepository moviesRepository;
  int currentPage = 1;
  PopularBloc(this.moviesRepository) : super(const PopularState()) {
    on<LoadNextPagePopularEvent>(_onLoadNextPage);
  }

  void _onLoadNextPage(
    LoadNextPagePopularEvent event,
    Emitter<PopularState> emit,
  ) async {
    if (state.isLoadingMovies) return;
    emit(state.copyWith(isLoadingMovies: true));
    final response = await moviesRepository.getNowPlaying(page: currentPage++);
    final newMovies = [...state.movies, ...response];
    print('length popular ${newMovies.length}');

    emit(state.copyWith(isLoadingMovies: false, isLoading: false, movies: newMovies, currentPage: currentPage++));
  }
}
