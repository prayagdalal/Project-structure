import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_app_bar_event.dart';
part 'bottom_app_bar_state.dart';

class BottomAppBarBloc extends Bloc<BottomAppBarEvent, BottomAppBarState> {
  BottomAppBarBloc() : super(BottomAppBarInitial()) {
    on<BottomAppBarClickedEvent>(bottomAppBarClickedEvent);
  }

  FutureOr<void> bottomAppBarClickedEvent(BottomAppBarClickedEvent event, Emitter<BottomAppBarState> emit) {
    emit(BottomAppBarSelectedState(event.index));
  }
}
