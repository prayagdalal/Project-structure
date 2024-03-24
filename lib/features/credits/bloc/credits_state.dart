part of 'credits_bloc.dart';

sealed class CreditsState {}

final class CreditsInitial extends CreditsState {}

final class CreditsChangeState extends CreditsState {
  int newCreditIndex;
  CreditsChangeState(this.newCreditIndex);
}
