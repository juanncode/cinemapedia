part of 'movie_cache_cubit.dart';

class MovieCacheState extends Equatable {
  final Map<String, Movie> movieCache;
  const MovieCacheState({this.movieCache = const {}});

  MovieCacheState copyWith({Map<String, Movie>? movieCache}) =>
      MovieCacheState(movieCache: movieCache ?? this.movieCache);

  @override
  List<Object> get props => [movieCache];
}
