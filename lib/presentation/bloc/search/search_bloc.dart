import 'dart:async';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository moviesRepository;
  Timer? _debounceTimer;
  SearchBloc(this.moviesRepository) : super(const SearchState()) {
    on<HandleMovieQuerytEvent>(_onHandleMovieQuery);
    on<GetMoviesSearchEvent>(_onLoadSearchMovies);
    on<CleanQueryEvent>(_onCleanQuery);
  }

  void _onHandleMovieQuery(
    HandleMovieQuerytEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      add(GetMoviesSearchEvent(event.query));
    });
  }

  void _onLoadSearchMovies(
    GetMoviesSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(movies: [], query: '', isLoading: false));
      return;
    }
    emit(state.copyWith(isLoading: true));
    print('peticion');
    final response = await moviesRepository.searchMovies(event.query);
    emit(state.copyWith(movies: response, query: event.query, isLoading: false));
  }

  void _onCleanQuery(
    CleanQueryEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(query: '', movies: [], isLoading: false));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
