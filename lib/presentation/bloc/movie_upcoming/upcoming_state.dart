part of 'upcoming_bloc.dart';

class UpcomingState extends Equatable {
  final bool isLoading;
  final bool isLoadingMovies;
  final int currentPage;
  final List<Movie> movies;

  const UpcomingState(
      {this.isLoadingMovies = false, this.isLoading = true, this.movies = const [], this.currentPage = 0});

  UpcomingState copyWith({
    bool? isLoading,
    bool? isLoadingMovies,
    List<Movie>? movies,
    int? currentPage,
  }) =>
      UpcomingState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object> get props => [isLoading, isLoadingMovies, currentPage, movies];
}
