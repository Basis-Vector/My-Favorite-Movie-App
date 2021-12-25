// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_tile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCardAdapter extends TypeAdapter<MovieCard> {
  @override
  final int typeId = 0;

  @override
  MovieCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieCard(
      movieName: fields[0] as String?,
      directorName: fields[1] as String?,
      moviePoster: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieCard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.movieName)
      ..writeByte(1)
      ..write(obj.directorName)
      ..writeByte(2)
      ..write(obj.moviePoster);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
