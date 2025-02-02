import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<MainEventChangeIndex>(_onChangeIndex);
    on<NavigateToAnotherScreenEvent>(_onNavigateToAnotherScreen);
  }

  void _onChangeIndex(MainEventChangeIndex event, Emitter<MainState> emit) {
    emit(state.copyWith(currentIndex: event.index, screen: Screen.values[event.index]));
  }

  void _onNavigateToAnotherScreen(NavigateToAnotherScreenEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(currentIndex: event.screen.index, screen: event.screen));
  }
}
