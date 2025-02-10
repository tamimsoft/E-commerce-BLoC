import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

enum Status { initial, valid, error, loading, success }

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupEventOnChangeFirstName>(_onChangeFirstName);
    on<SignupEventOnChangeLastName>(_onChangeLastName);
    on<SignupEventOnChangeEmail>(_onChangeEmail);
    on<SignupEventOnChangePassword>(_onChangePassword);
    on<SignupEventOnChangePhone>(_onChangePhone);
    on<SignupEventOnChangeCity>(_onChangeCity);
    on<SignupEventSignupButton>(_onTapSignupButton);
  }

  void _onChangeFirstName(SignupEventOnChangeFirstName event, Emitter<SignupState> emit) {
    emit(state.copyWith(firstName: event.firstName));
    _validateFields(emit);
  }

  void _onChangeLastName(SignupEventOnChangeLastName event, Emitter<SignupState> emit) {
    emit(state.copyWith(lastName: event.lastName));
    _validateFields(emit);
  }

  void _onChangeEmail(SignupEventOnChangeEmail event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email));
    _validateFields(emit);
  }

  void _onChangePassword(SignupEventOnChangePassword event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: event.password));
    _validateFields(emit);
  }

  void _onChangePhone(SignupEventOnChangePhone event, Emitter<SignupState> emit) {
    emit(state.copyWith(phone: event.phone));
    _validateFields(emit);
  }

  void _onChangeCity(SignupEventOnChangeCity event, Emitter<SignupState> emit) {
    emit(state.copyWith(city: event.city));
    _validateFields(emit);
  }

  void _validateFields(Emitter<SignupState> emit) {
    if (state.firstName.isNotEmpty &&
        state.lastName.isNotEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.city.isNotEmpty) {
      emit(state.copyWith(status: Status.valid, errorMsg: ''));
    }
  }

  Future<void> _onTapSignupButton(SignupEventSignupButton event, Emitter<SignupState> emit) async {
    if (state.status != Status.valid) {
      emit(state.copyWith(status: Status.error, errorMsg: 'Please fill all fields'));
      return;
    }
    emit(state.copyWith(status: Status.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: Status.success, errorMsg: 'Signup Success!'));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
