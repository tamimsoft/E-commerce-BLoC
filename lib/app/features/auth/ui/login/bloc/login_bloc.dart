import 'package:equatable/equatable.dart';
import 'package:fakestore/app/utils/helper/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEventOnChangeEmail>(_onChangeEmail);
    on<LoginEventOnChangePassword>(_onChangePassword);
    on<LoginEventLoginButton>(_onTapLoginButton);
  }

  void _onChangeEmail(LoginEventOnChangeEmail event, Emitter<LoginState> emit) {
    if (event.email.isEmail) {
      emit(state.copyWith(email: event.email));
    } else {
      emit(state.copyWith(email: ''));
    }
  }

  void _onChangePassword(LoginEventOnChangePassword event, Emitter<LoginState> emit) {
    if (event.password.isNotEmpty) {
      emit(state.copyWith(password: event.password));
    } else {
      emit(state.copyWith(password: ''));
    }
  }

  Future<void> _onTapLoginButton(LoginEventLoginButton event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: Status.loaded, errorMsg: 'Login Success!'));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
