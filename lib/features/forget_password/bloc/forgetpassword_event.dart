part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordEvent {}

class ForgetBackButtonClickedEvent extends ForgetpasswordEvent {}

class ForgetSendButtonClickedEvent extends ForgetpasswordEvent {}
