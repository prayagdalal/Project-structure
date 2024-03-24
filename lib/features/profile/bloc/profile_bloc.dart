import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileSwitchClickedEvent>(profileSwitchClickedEvent);
  }

  FutureOr<void> profileSwitchClickedEvent(ProfileSwitchClickedEvent event, Emitter<ProfileState> emit) {
    emit(ProfileSwitchState(event.switchStatus));
  }
}
