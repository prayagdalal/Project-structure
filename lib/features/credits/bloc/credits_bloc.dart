import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'credits_event.dart';
part 'credits_state.dart';

class CreditsBloc extends Bloc<CreditsEvent, CreditsState> {
  CreditsBloc() : super(CreditsInitial()) {
    on<CreditChangeButtonPressedEvent>(creditChangeButtonPressedEvent);
  }

  FutureOr<void> creditChangeButtonPressedEvent(CreditChangeButtonPressedEvent event, Emitter<CreditsState> emit) {
    emit(CreditsChangeState(event.creditIndex));
  }
}
