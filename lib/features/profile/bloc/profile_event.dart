part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class ProfileSwitchClickedEvent extends ProfileEvent {
  bool switchStatus;
  ProfileSwitchClickedEvent(this.switchStatus);
}
