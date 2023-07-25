part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Movie> movies;
  final String query;
  final bool isLoading;
  const SearchState({this.movies = const [], this.query = '', this.isLoading = false});

  SearchState copyWith({List<Movie>? movies, String? query, bool? isLoading}) => SearchState(
        movies: movies ?? this.movies,
        query: query ?? this.query,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [movies, query, isLoading];
}
