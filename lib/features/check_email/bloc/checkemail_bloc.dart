import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkemail_event.dart';
part 'checkemail_state.dart';

class CheckemailBloc extends Bloc<CheckemailEvent, CheckemailState> {
  CheckemailBloc() : super(CheckemailInitial()) {
    on<CheckemailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
