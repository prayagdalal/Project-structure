part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

sealed class OnboardingActionState extends OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingNavigateToSignupPageActionState extends OnboardingActionState {}

final class OnboardingNavigateToLoginPageActionState extends OnboardingActionState {}
