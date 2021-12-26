import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/splash/bloc/splash_event.dart';
import 'package:movie_app/modules/splash/bloc/splash_state.dart';
import 'package:movie_app/storage/MovieSharedPreferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState());
  bool isUserLoggedIn = false;

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitialEvent) {
      isUserLoggedIn = await MovieSharedPreferences()
              .getBoolForKey(preferencesKeys.kUserLoggedIn) ??
          false;
      yield NavigateToScreenState(isLoggedInUser: isUserLoggedIn);
    }
  }
}
