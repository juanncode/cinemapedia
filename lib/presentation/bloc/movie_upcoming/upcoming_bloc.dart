import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final MoviesRepository moviesRepository;
  int currentPage = 1;
  UpcomingBloc(this.moviesRepository) : super(const UpcomingState()) {
    on<LoadNextPageUpcomingEvent>(_onLoadNextPage);
  }

  void _onLoadNextPage(
    LoadNextPageUpcomingEvent event,
    Emitter<UpcomingState> emit,
  ) async {
    if (state.isLoadingMovies) return;
    emit(state.copyWith(isLoadingMovies: true));
    final response = await moviesRepository.getUpComing(page: currentPage++);
    final newMovies = [...state.movies, ...response];
    print('length popular ${newMovies.length}');

    emit(state.copyWith(isLoadingMovies: false, isLoading: false, movies: newMovies, currentPage: currentPage++));
  }
}
