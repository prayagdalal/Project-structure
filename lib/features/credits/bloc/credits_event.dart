part of 'credits_bloc.dart';

sealed class CreditsEvent {}

final class CreditChangeButtonPressedEvent extends CreditsEvent {
  int creditIndex;
  CreditChangeButtonPressedEvent(this.creditIndex);
}
