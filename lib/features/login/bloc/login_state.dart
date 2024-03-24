part of 'login_bloc.dart';

sealed class LoginState {}

sealed class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

final class LoginPasswordButtonTrueState extends LoginState {
  bool newStatus;
  LoginPasswordButtonTrueState(this.newStatus);
}

final class LoginBackButtonNavigateActionState extends LoginActionState {}

final class LoginSignupButtonNavigateActionState extends LoginActionState {}

final class LoginForgetPasswordNavigateActionState extends LoginActionState {}

final class LoginLoadingState extends LoginActionState {}

final class LoginSuccessedState extends LoginActionState {
  Response responseObj;
  LoginSuccessedState(this.responseObj);
}

final class LoginErrorState extends LoginState {
  Response responseObj;
  LoginErrorState(this.responseObj);
}

final class LoginFailedState extends LoginActionState {}
