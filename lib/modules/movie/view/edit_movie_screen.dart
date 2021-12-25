import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  var galleryFile;

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
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.movieCard.moviePoster!.isNotEmpty)
                GestureDetector(
                  onTap: () async {
                    galleryFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (galleryFile != null) {
                        widget.movieCard.moviePoster = base64Encode(
                            Io.File(galleryFile.path).readAsBytesSync());
                      }
                    });
                  },
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue),
                    child: Image.memory(
                      base64Decode(
                        widget.movieCard.moviePoster ?? '',
                      ),
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              if (widget.movieCard.moviePoster!.isEmpty)
                GestureDetector(
                  onTap: () async {
                    galleryFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (galleryFile != null) {
                        widget.movieCard.moviePoster = base64Encode(
                            Io.File(galleryFile.path).readAsBytesSync());
                      }
                    });
                  },
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: 40,
                    )),
                  ),
                ),
              SizedBox(
                height: 30,
              ),
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
                  textCapitalization: TextCapitalization.words,
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
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Container(
                height: 45,
                width: 150,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (widget.movieCard.moviePoster!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Add The Movie Poster")));
                    } else if (_movieNameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter Valid Movie Name")));
                    } else if (_directorNameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter Valid Director Name")));
                    } else {
                      if (widget.isNewMovie ?? false) {
                        BlocProvider.of<MoviesListBloc>(context)
                            .add(MovieAddEvent(
                          movieName: _movieNameController.text,
                          directorName: _directorNameController.text,
                          moviePoster: widget.movieCard.moviePoster ?? "",
                        ));
                        Navigator.pop(context);
                      } else {
                        BlocProvider.of<MoviesListBloc>(context)
                            .add(MovieEditEvent(
                          movieName: _movieNameController.text,
                          directorName: _directorNameController.text,
                          index: widget.index ?? 0,
                          moviePoster: widget.movieCard.moviePoster ?? "",
                        ));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
