import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeState());

  void checkAuthentication() async{
    emit(state.copyWith(status: Status.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isAuthenticated: false, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
