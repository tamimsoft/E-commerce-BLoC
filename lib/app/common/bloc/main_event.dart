part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainEventChangeIndex extends MainEvent {
  final int index;

  const MainEventChangeIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class MoveToCategoryEvent extends MainEvent {}

class NavigateToAnotherScreenEvent extends MainEvent {
  final Screen screen;

  const NavigateToAnotherScreenEvent({required this.screen});

  @override
  List<Object> get props => [screen];
}
