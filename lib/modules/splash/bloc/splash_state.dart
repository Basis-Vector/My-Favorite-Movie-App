abstract class SplashState {}

class InitialState extends SplashState {}

class NavigateToScreenState extends SplashState {
  bool isLoggedInUser;

  NavigateToScreenState({required this.isLoggedInUser});
}
