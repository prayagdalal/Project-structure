part of 'signup_bloc.dart';

sealed class SignupState {}

sealed class SignupActionState extends SignupState {}

final class SignupInitial extends SignupState {}

final class SignupPasswordButtonTrueState extends SignupState {
  bool newStatus;
  SignupPasswordButtonTrueState(this.newStatus);
}

final class SignupPasswordButtonFalseState extends SignupState {}

final class SignupBackButtonNavigateActionState extends SignupActionState {}

final class SignupLoginButtonNavigateActionState extends SignupActionState {}

final class SignupLoadingState extends SignupActionState {}

final class SignupSuccessedState extends SignupActionState {
  Response responseObj;
  SignupSuccessedState(this.responseObj);
}

final class SignupErrorState extends SignupActionState {
  Response responseObj;
  SignupErrorState(this.responseObj);
}

final class SignupFailedState extends SignupActionState {}

final class SignupCountryCodeChangedState extends SignupActionState {
  String code;

  SignupCountryCodeChangedState(this.code);
}
