part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final bool isLoading;
  final int currentPage;
  final List<Movie> movies;

  const MovieState({this.isLoading = true, this.movies = const [], this.currentPage = 0});

  MovieState copyWith({
    bool? isLoading,
    List<Movie>? movies,
    int? currentPage,
  }) =>
      MovieState(
        isLoading: isLoading ?? this.isLoading,
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object> get props => [];
}
