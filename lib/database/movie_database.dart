import 'package:hive/hive.dart';
import 'package:movie_app/models/movie_tile.dart';

class MovieDatabase {
  String _boxName = "movieCard";

  // open a box
  Future<Box> moviesListBox() async {
    var box = await Hive.openBox<MovieCard>(_boxName);
    return box;
  }

  // get full note
  Future<List<MovieCard>> getMoviesList() async {
    final box = await moviesListBox();
    List<MovieCard> moviesList = [];
    (box.values).forEach((value) {
      moviesList.add(value);
    });
    return moviesList;
  }

  // to add data in box
  Future<void> addToBox(MovieCard movieCard) async {
    final box = await moviesListBox();
    await box.add(movieCard);
  }

  // delete data from box
  Future<void> deleteFromBox(int index) async {
    final box = await moviesListBox();
    await box.deleteAt(index);
  }

  // delete all data from box
  Future<void> deleteAll() async {
    final box = await moviesListBox();
    await box.clear();
  }

  // update data
  Future<void> updateNote(int index, MovieCard movieCard) async {
    final box = await moviesListBox();
    await box.putAt(index, movieCard);
  }
}
