part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class HandleMovieQuerytEvent extends SearchEvent {
  final String query;

  const HandleMovieQuerytEvent(this.query);
}

class GetMoviesSearchEvent extends SearchEvent {
  final String query;

  const GetMoviesSearchEvent(this.query);
}

class CleanQueryEvent extends SearchEvent {
  const CleanQueryEvent();
}
