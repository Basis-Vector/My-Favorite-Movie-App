import 'package:movie_app/database/movie_database.dart';
import 'package:movie_app/models/movie_tile.dart';

import 'movies_list_event.dart';
import 'movies_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  MoviesListBloc(this._movieDatabase) : super(InitialState());
  final MovieDatabase _movieDatabase;
  List<MovieCard> _moviesListCard = [];

  @override
  Stream<MoviesListState> mapEventToState(MoviesListEvent event) async* {
    if (event is MovieInitialEvent) {
      yield* _mapInitialEventToState();
    } else if (event is MovieAddEvent) {
      yield* _mapMovieAddEventToState(
          directorName: event.directorName, movieName: event.movieName, moviePoster: event.moviePoster);
    }
    if (event is MovieEditEvent) {
      yield* _mapMovieEditEventToState(
        movieName: event.movieName,
        directorName: event.directorName,
        index: event.index,
        moviePoster: event.moviePoster,
      );
    }

   else if (event is MovieDeleteEvent) {
      yield* _mapMovieDeleteEventToState(index: event.index);
    }
  }

  Stream<MoviesListState> _mapInitialEventToState() async* {
    yield MoviesLoading();
    await _getMoviesList();
    yield CurrentMovieState(moviesList: _moviesListCard);
  }

  Stream<MoviesListState> _mapMovieAddEventToState(
      {required String movieName, required String directorName,required String moviePoster}) async* {
    yield MoviesLoading();
    await _addToMoviesList(movieName: movieName, directorName: directorName,moviePoster:moviePoster );
    yield CurrentMovieState(moviesList: _moviesListCard);
  }

  Stream<MoviesListState> _mapMovieEditEventToState(
      {required String movieName,
      required String directorName,
      required String moviePoster,
      required int index}) async* {
    yield MoviesLoading();
    await _updateMovie(movieName: movieName,directorName: directorName, index: index,moviePoster:moviePoster);
    yield CurrentMovieState(moviesList: _moviesListCard);
  }


  Stream<MoviesListState> _mapMovieDeleteEventToState(
      {required int index}) async* {
    yield MoviesLoading();
    await _removeFromMoviesList(index: index);
    yield CurrentMovieState(moviesList: _moviesListCard);

  }

  // Helper Functions
  Future<void> _getMoviesList() async {
    await _movieDatabase.getMoviesList().then((value) {
      _moviesListCard = value;
    });
  }

  Future<void> _addToMoviesList(
      {required String movieName, required String directorName, required String moviePoster,}) async {
    await _movieDatabase
        .addToBox(MovieCard(movieName: movieName, directorName: directorName, moviePoster: moviePoster));
    await _getMoviesList();
  }

  Future<void> _updateMovie(
      {required String movieName,
        required String directorName,
        required String moviePoster,
        required int index}) async {
    await _movieDatabase.updateNote(
        index, MovieCard(movieName: movieName, directorName: directorName,moviePoster: moviePoster));
    await _getMoviesList();
  }

  Future<void> _removeFromMoviesList({required int index}) async {
    await _movieDatabase.deleteFromBox(index);
    await _getMoviesList();
  }
}
