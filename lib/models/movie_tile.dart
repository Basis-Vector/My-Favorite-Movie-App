import 'package:hive/hive.dart';

part 'movie_tile.g.dart';

@HiveType(typeId: 0)
class MovieCard extends HiveObject {
  @HiveField(0)
  String? movieName;
  @HiveField(1)
  String? directorName;
  @HiveField(2)
  String? moviePoster;

  MovieCard({this.movieName, this.directorName,this.moviePoster});
}
