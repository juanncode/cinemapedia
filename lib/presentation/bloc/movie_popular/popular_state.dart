part of 'popular_bloc.dart';

class PopularState extends Equatable {
  final bool isLoading;
  final bool isLoadingMovies;
  final int currentPage;
  final List<Movie> movies;

  const PopularState(
      {this.isLoadingMovies = false, this.isLoading = true, this.movies = const [], this.currentPage = 0});

  PopularState copyWith({
    bool? isLoading,
    bool? isLoadingMovies,
    List<Movie>? movies,
    int? currentPage,
  }) =>
      PopularState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object> get props => [isLoading, isLoadingMovies, currentPage, movies];
}
