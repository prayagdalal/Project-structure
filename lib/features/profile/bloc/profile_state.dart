part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileSwitchState extends ProfileState {
  bool newSwitchStatus;
  ProfileSwitchState(this.newSwitchStatus);
}
