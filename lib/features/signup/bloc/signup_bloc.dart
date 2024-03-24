import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:opx_certification/features/signup/repos/signup_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupBacktButtonClickedEvent>(signupBacktButtonClickedEvent);
    on<SignupCreateAccountButtonClickedEvent>(signupCreateAccountButtonClickedEvent);
    on<SignupLoginButtonClickedEvent>(signupLoginButtonClickedEvent);
    on<SignupChangePasswordStatusevent>(signupChangePasswordStatusevent);
    on<SignupChnageCountryCodeEvent>(signupChnageCountryCodeEvent);
  }

  FutureOr<void> signupBacktButtonClickedEvent(SignupBacktButtonClickedEvent event, Emitter<SignupState> emit) {
    emit(SignupBackButtonNavigateActionState());
  }

  Future<FutureOr<void>> signupCreateAccountButtonClickedEvent(
      SignupCreateAccountButtonClickedEvent event, Emitter<SignupState> emit) async {
    try {
      log(event.company + event.email + event.name + event.password + event.phone + event.siren);
      emit(SignupLoadingState());
      var responseData = await SignupRepo.registerUser(
          event.name, event.email, event.password, event.phone, event.siren, event.company);
      if (responseData!.statusCode! >= 200 && responseData.statusCode! <= 300) {
        emit(SignupSuccessedState(responseData));
      }
      if (responseData.statusCode == 422) {
        emit(SignupErrorState(responseData));
      }
    } catch (e) {
      log(e.toString());
      emit(SignupFailedState());
    }
  }

  FutureOr<void> signupLoginButtonClickedEvent(SignupLoginButtonClickedEvent event, Emitter<SignupState> emit) {
    emit(SignupLoginButtonNavigateActionState());
  }

  FutureOr<void> signupChangePasswordStatusevent(SignupChangePasswordStatusevent event, Emitter<SignupState> emit) {
    emit(SignupPasswordButtonTrueState(!event.status));
  }

  FutureOr<void> signupChnageCountryCodeEvent(SignupChnageCountryCodeEvent event, Emitter<SignupState> emit) {
    emit(SignupCountryCodeChangedState(event.code));
  }
}
