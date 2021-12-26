import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/database/movie_database.dart';
import 'package:movie_app/models/movie_tile.dart';
import 'package:movie_app/modules/login/bloc/login_state.dart';
import 'package:movie_app/modules/login/view/sign_up_screen.dart';
import 'package:movie_app/modules/movie/bloc/movies_list_bloc.dart';
import 'package:movie_app/modules/movie/view/edit_movie_screen.dart';
import 'package:movie_app/modules/splash/bloc/splash_bloc.dart';

import 'modules/login/view/login_screen.dart';
import 'modules/movie/view/movies_list_screen.dart';
import 'modules/splash/bloc/splash_state.dart';
import 'modules/splash/view/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<MovieCard>(MovieCardAdapter());
  await Hive.openBox<MovieCard>("movieCard");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blueAccent, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _movieBloc = MoviesListBloc(MovieDatabase());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(),
        child: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/login":
            return MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            );
          case "/signUp":
            return MaterialPageRoute(
              builder: (context) {
                return SignUpScreen();
              },
            );
          case "/movieListScreen":
            return MaterialPageRoute(builder: (context) {
              return BlocProvider<MoviesListBloc>.value(
                value: _movieBloc,
                child: MoviesListScreen(),
                // value: _movieBloc,
                // child: MoviesListScreen(),
              );
            });
          case "/editMovieScreen":
            MovieTileArgument args = settings.arguments as MovieTileArgument;
            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider<MoviesListBloc>.value(
                  value: _movieBloc,
                  child: EditMovieScreen(
                    index: args.index,
                    movieCard: MovieCard(
                        movieName: args.movieName,
                        directorName: args.directorName,
                        moviePoster: args.moviePoster),
                    isNewMovie: args.isNewMovie,
                  ),
                );
              },
            );
        }
      },
    );
  }
}
