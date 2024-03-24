// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginAccountButtonClickedEvent extends LoginEvent {
  String email;
  String password;
  LoginAccountButtonClickedEvent({
    required this.email,
    required this.password,
  });
}

class LoginSignupButtonClickedEvent extends LoginEvent {}

class LoginpBacktButtonClickedEvent extends LoginEvent {}

class LoginFogetPasswordButtonClickedEvent extends LoginEvent {}

class LoginChangePasswordStatusevent extends LoginEvent {
  bool status;

  LoginChangePasswordStatusevent(this.status);
}
