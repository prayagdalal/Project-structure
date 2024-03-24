part of 'bottom_app_bar_bloc.dart';

sealed class BottomAppBarState {}

final class BottomAppBarInitial extends BottomAppBarState {}

class BottomAppBarSelectedState extends BottomAppBarState {
  int selectedIndex;
  BottomAppBarSelectedState(this.selectedIndex);
}
