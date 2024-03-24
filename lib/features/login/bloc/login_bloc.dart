import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';
import 'package:opx_certification/features/login/repos/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginpBacktButtonClickedEvent>(loginpBacktButtonClickedEvent);
    on<LoginAccountButtonClickedEvent>(loginAccountButtonClickedEvent);
    on<LoginSignupButtonClickedEvent>(loginSignupButtonClickedEvent);
    on<LoginChangePasswordStatusevent>(loginChangePasswordStatusevent);
    on<LoginFogetPasswordButtonClickedEvent>(loginFogetPasswordButtonClickedEvent);
  }

  FutureOr<void> loginpBacktButtonClickedEvent(LoginpBacktButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginBackButtonNavigateActionState());
  }

  Future<FutureOr<void>> loginAccountButtonClickedEvent(
      LoginAccountButtonClickedEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      var responseData = await LoginRepo.loginUser(event.email, event.password);
      if (responseData!.statusCode! >= 200 && responseData.statusCode! <= 300) {
        emit(LoginSuccessedState(responseData));
      } else {
        emit(LoginFailedState());
      }
    } catch (e) {
      emit(LoginFailedState());
    }
  }

  FutureOr<void> loginSignupButtonClickedEvent(LoginSignupButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginSignupButtonNavigateActionState());
  }

  FutureOr<void> loginChangePasswordStatusevent(LoginChangePasswordStatusevent event, Emitter<LoginState> emit) {
    emit(LoginPasswordButtonTrueState(!event.status));
  }

  FutureOr<void> loginFogetPasswordButtonClickedEvent(
      LoginFogetPasswordButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginForgetPasswordNavigateActionState());
  }
}
