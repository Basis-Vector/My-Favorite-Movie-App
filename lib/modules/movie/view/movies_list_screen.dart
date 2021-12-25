import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_tile.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_bloc.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_event.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_state.dart';

import 'edit_movie_screen.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  List<MovieCard> list = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<MoviesListBloc>(context).add(MovieInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favorite Movies List",
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<MoviesListBloc, MoviesListState>(
          builder: (context, state) {
        if (state is CurrentMovieState) {
          list = state.moviesList;
          return Container(
            color: Colors.white,
            child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    borderOnForeground: true,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlue),
                            child: Image.memory(
                              base64Decode(list[index].moviePoster ?? ""),
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 15),
                            child: Column(
                              children: [
                                Text(
                                  list[index].movieName ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arvo',
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  list[index].directorName ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Arvo',
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 5),
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/editMovieScreen",
                                      arguments: MovieTileArgument(
                                          movieName: list[index].movieName,
                                          directorName:
                                              list[index].directorName,
                                          index: index,
                                          isNewMovie: false,
                                          moviePoster: list[index].moviePoster),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    BlocProvider.of<MoviesListBloc>(context)
                                        .add(MovieDeleteEvent(index: index));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          );
        } else if (state is MoviesLoading) {
          return Center(
              child: Container(
            child: CircularProgressIndicator(
              color: Colors.blue,
              value: 5,
            ),
          ));
        } else {
          return Container();
        }
      }),

      //),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/editMovieScreen",
            arguments: MovieTileArgument(
                movieName: "",
                directorName: "",
                index: 0,
                isNewMovie: true,
                moviePoster: ""),
          );
        },
        // }

        // ,
      ),
    );
  }
}

class MovieTileArgument {
  String? movieName;
  String? moviePoster;
  bool? isNewMovie;
  String? directorName;
  int? index;

  MovieTileArgument({
    required this.movieName,
    required this.directorName,
    required this.index,
    required this.isNewMovie,
    required this.moviePoster,
  });
}
