part of 'main_bloc.dart';

enum Screen { home, category, cart, wishlist }

class MainState extends Equatable {
  final Screen screen;
  final int currentIndex;
  final String? errorMessage;

  const MainState({
    this.screen = Screen.home,
    this.currentIndex = 0,
    this.errorMessage,
  });

  MainState copyWith({
    Screen? screen,
    int? currentIndex,
    String? errorMessage,
  }) {
    return MainState(
      screen: screen ?? this.screen,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [screen, currentIndex, errorMessage ?? ''];
}
