part of 'bottom_app_bar_bloc.dart';

sealed class BottomAppBarEvent {}

class BottomAppBarClickedEvent extends BottomAppBarEvent {
  int index;
  BottomAppBarClickedEvent(this.index);
}
