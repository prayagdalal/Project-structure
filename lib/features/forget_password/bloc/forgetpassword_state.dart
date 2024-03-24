part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordState {}

sealed class ForgetpasswordActionState extends ForgetpasswordState {}

final class ForgetpasswordInitial extends ForgetpasswordState {}

final class ForgetBackButtonNavigationState extends ForgetpasswordActionState {}

final class ForgetSendButtonState extends ForgetpasswordActionState {}
