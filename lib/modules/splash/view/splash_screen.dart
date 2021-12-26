import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/splash/bloc/splash_bloc.dart';
import 'package:movie_app/modules/splash/bloc/splash_event.dart';
import 'package:movie_app/modules/splash/bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SplashBloc, SplashState>(
        buildWhen: (previous, current) => _isBuildWidgetState(current),
        listenWhen: (previous, current) => !_isBuildWidgetState(current),
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/login");
                //Navigator.pushNamed(context, "/movieListScreen");
              },
              child: Center(
                child: Text(
                  "My \nFavorite Movies",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Arvo',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is NavigateToScreenState) {
            if (state.isLoggedInUser) {
              Navigator.pushNamed(context, "/movieListScreen");
            } else {
              Navigator.pushNamed(context, "/login");
            }
          }
        },
      ),
    );
  }

  bool _isBuildWidgetState(SplashState state) {
    return state is InitialState;
  }
}
