import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordInitial()) {
    on<ForgetBackButtonClickedEvent>(forgetBackButtonClickedEvent);
    on<ForgetSendButtonClickedEvent>(forgetSendButtonClickedEvent);
  }

  FutureOr<void> forgetSendButtonClickedEvent(ForgetSendButtonClickedEvent event, Emitter<ForgetpasswordState> emit) {
    emit(ForgetSendButtonState());
  }

  FutureOr<void> forgetBackButtonClickedEvent(ForgetBackButtonClickedEvent event, Emitter<ForgetpasswordState> emit) {
    emit(ForgetBackButtonNavigationState());
  }
}
