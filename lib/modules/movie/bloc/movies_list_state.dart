import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_tile.dart';

abstract class MoviesListState extends Equatable {
  @override
  List<Object> get props => [];
}

// initial
class InitialState extends MoviesListState {}

// loading
class MoviesLoading extends MoviesListState {}

// edit movie
class EditMovieState extends MoviesListState {
  final MovieCard movieCard;

  EditMovieState({required this.movieCard});
}

// delete movie
class DeleteMovieState extends MoviesListState {
  final MovieCard movieCard;

  DeleteMovieState({required this.movieCard});
}

//  your current movies
class CurrentMovieState extends MoviesListState {
  final List<MovieCard> moviesList; // get all notes

  CurrentMovieState({required this.moviesList});
}

// new movie
class AddMovieState extends MoviesListState {}
