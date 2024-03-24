// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

sealed class SignupEvent {}

class SignupCreateAccountButtonClickedEvent extends SignupEvent {
  String name;
  String email;
  String password;
  String phone;
  String siren;
  String company;
  SignupCreateAccountButtonClickedEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.siren,
    required this.company,
  });
}

class SignupLoginButtonClickedEvent extends SignupEvent {}

class SignupBacktButtonClickedEvent extends SignupEvent {}

class SignupChangePasswordStatusevent extends SignupEvent {
  bool status;
  SignupChangePasswordStatusevent(this.status);
}

class SignupChnageCountryCodeEvent extends SignupEvent {
  String code;
  SignupChnageCountryCodeEvent({
    required this.code,
  });
}
