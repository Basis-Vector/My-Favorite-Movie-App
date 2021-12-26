abstract class LoginState {}

class InitialState extends LoginState{}

class LoginSucessState extends LoginState{}

class LoginFailedState extends LoginState{
  String error;
  LoginFailedState({required this.error});
}
class NoInternetState extends LoginState{}
