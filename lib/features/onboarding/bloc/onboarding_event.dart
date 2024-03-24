part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

class OnboardingCreateAccountButtonNavigateEvent extends OnboardingEvent {}

class OnboardingAlreadyHaveAccountButtonNavigateEvent extends OnboardingEvent {}
