part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadNextPageEvent extends MovieEvent {
  final int currentPage;
  const LoadNextPageEvent(this.currentPage);
}
