import 'dart:async';
import 'package:fakestore/app/features/auth/service/auth_service.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/utils/helper/functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  Timer? _countDownTimer;

  AuthBloc(this._authService) : super(AuthState()) {
    on<AuthEventCheckAuth>(_checkAuthentication);
    on<AuthEventEmailChange>(_onEmailChange);
    on<AuthEventEmailVerifyButton>(_onPressEmailVerifyButton);
    on<AuthEventReSendEmailVerifyButton>(_onPressReSendEmailVerifyButton);
    on<AuthEventOtpChange>(_onOtpChange);
    on<AuthEventOtpVerifyButton>(_onPressOtpVerifyButton);
  }

  Future<void> _checkAuthentication(AuthEventCheckAuth event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authService.isAuthenticated().then((value) {
        if (value) {
          emit(state.copyWith(status: AuthStatus.loaded));
        } else {
          emit(state.copyWith(status: AuthStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  void _onEmailChange(AuthEventEmailChange event, Emitter<AuthState> emit) {
    if (event.email.isEmail) {
      emit(state.copyWith(email: event.email));
    } else {
      emit(state.copyWith(email: ''));
    }
  }

  Future<void> _onPressEmailVerifyButton(AuthEventEmailVerifyButton event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _authService.sendEmailVerification(email: state.email);

      emit(state.copyWith(status: AuthStatus.otpSent));
      await _startCountDown(emit);
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  Future<void> _onPressReSendEmailVerifyButton(AuthEventReSendEmailVerifyButton event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loadingTexBtn));

    try {
      await _authService.sendEmailVerification(email: state.email);
      await _startCountDown(emit);
      emit(state.copyWith(status: AuthStatus.otpReSent));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  void _onOtpChange(AuthEventOtpChange event, Emitter<AuthState> emit) {
    if (event.otp.length == AppString.otpLength) {
      emit(state.copyWith(otp: event.otp));
    }
  }

  Future<void> _onPressOtpVerifyButton(AuthEventOtpVerifyButton event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authService.otpVerify(email: state.email, otp: state.otp);
      emit(state.copyWith(status: AuthStatus.otpVerified));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  Future<void> _startCountDown(Emitter<AuthState> emit, {int duration = 30}) async {
    // Cancel any existing timer to avoid overlapping
    _countDownTimer?.cancel();

    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration > 0) {
        duration--;
        // Ensure emit is not called if the Bloc is closed
        if (!emit.isDone) {
          emit(state.copyWith(remainingTime: duration));
        } else {
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });

    // Wait for the timer to complete
    await Future.delayed(Duration(seconds: duration + 1));
  }

  @override
  Future<void> close() {
    // Cancel the timer when the bloc is closed
    _countDownTimer?.cancel();
    return super.close();
  }
}
