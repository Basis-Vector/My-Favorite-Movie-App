import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_tile.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_bloc.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_event.dart';

class EditMovieScreen extends StatefulWidget {
  final MovieCard movieCard;
  final int? index;
  final bool? isNewMovie;

  const EditMovieScreen(
      {Key? key,
      required this.index,
      required this.movieCard,
      required this.isNewMovie})
      : super(key: key);

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  @override
  Widget build(BuildContext context) {
    String? movieName = widget.movieCard.movieName;
    String? directorName = widget.movieCard.directorName;
    final _movieNameController = TextEditingController(text: movieName);
    final _directorNameController = TextEditingController(text: directorName);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Movie"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _movieNameController,
              maxLength: 25,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                labelText: 'Movie Name',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _directorNameController,
              maxLength: 25,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                labelText: 'Director Name',
              ),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              if (widget.isNewMovie??false) {
                BlocProvider.of<MoviesListBloc>(context).add(MovieAddEvent(
                  movieName: _movieNameController.text,
                  directorName: _directorNameController.text,
                ));
                Navigator.pop(context);
              } else {
                BlocProvider.of<MoviesListBloc>(context).add(MovieEditEvent(
                  movieName: _movieNameController.text,
                  directorName: _directorNameController.text,
                  index: widget.index ?? 0,
                ));
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}
