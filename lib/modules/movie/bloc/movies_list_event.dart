import 'package:equatable/equatable.dart';

abstract class MoviesListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// initial event
class MovieInitialEvent extends MoviesListEvent {}

// add event
class MovieAddEvent extends MoviesListEvent {
  final String movieName, directorName;

  MovieAddEvent({required this.movieName, required this.directorName});
}

// edit event
class MovieEditEvent extends MoviesListEvent {
  final String movieName, directorName;
  final int index;

  MovieEditEvent(
      {required this.movieName,
      required this.directorName,
      required this.index});
}

// delete event
class MovieDeleteEvent extends MoviesListEvent {
  final int index;

  MovieDeleteEvent({required this.index});
}
