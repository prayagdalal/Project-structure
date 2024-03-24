part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final CertificateModel certificateModel;

  HomeLoaded({required this.certificateModel});

  @override
  List<Object?> get props => [certificateModel];
}

final class HomeError extends HomeState {}
