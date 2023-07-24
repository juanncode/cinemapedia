part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final bool isLoading;
  final bool isLoadingMovies;
  final int currentPage;
  final List<Movie> movies;

  const MovieState({this.isLoadingMovies = false, this.isLoading = true, this.movies = const [], this.currentPage = 0});

  MovieState copyWith({
    bool? isLoading,
    bool? isLoadingMovies,
    List<Movie>? movies,
    int? currentPage,
  }) =>
      MovieState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object> get props => [isLoading, isLoadingMovies, currentPage, movies];
}
