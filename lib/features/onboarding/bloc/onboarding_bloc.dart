import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingCreateAccountButtonNavigateEvent>(onboardingCreateAccountButtonNavigateEvent);
    on<OnboardingAlreadyHaveAccountButtonNavigateEvent>(onboardingAlreadyHaveAccountButtonNavigateEvent);
  }

  FutureOr<void> onboardingCreateAccountButtonNavigateEvent(
      OnboardingCreateAccountButtonNavigateEvent event, Emitter<OnboardingState> emit) {
    print('go to create account');
    emit(OnboardingNavigateToSignupPageActionState());
  }

  FutureOr<void> onboardingAlreadyHaveAccountButtonNavigateEvent(
      OnboardingAlreadyHaveAccountButtonNavigateEvent event, Emitter<OnboardingState> emit) {
    print('go to login account');
    emit(OnboardingNavigateToLoginPageActionState());
  }
}
