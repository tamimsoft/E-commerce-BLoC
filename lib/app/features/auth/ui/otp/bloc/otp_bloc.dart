import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _countDownTimer;
  OtpBloc() : super(OtpState()) {
    on<OtpEventOnChangeOtp>(_onChangeOtp);
    on<OtpEventVerifyButton>(_onTapVerifyButton);
    on<OtpEventReSendOtpButton>(_onTapReSendOtpButton);
  }

  void _onChangeOtp(OtpEventOnChangeOtp event, Emitter<OtpState> emit) {
    if (event.otp.isNotEmpty) {
      emit(state.copyWith(otp: event.otp));
    } else {
      emit(state.copyWith(otp: ''));
    }
  }

  Future<void> _onTapVerifyButton(OtpEventVerifyButton event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }


  Future<void> _onTapReSendOtpButton(OtpEventReSendOtpButton event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: Status.loaded));

    try {
      // await _authService.signUp(password: state.email);
      await _startCountDown(emit);
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> _startCountDown(Emitter<OtpState> emit, {int duration = 30}) async {
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
