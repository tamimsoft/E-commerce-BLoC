part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpEventOnChangeOtp extends OtpEvent {
  final String otp;

  const OtpEventOnChangeOtp({required this.otp});

  @override
  List<Object> get props => [otp];
}

class OtpEventVerifyButton extends OtpEvent {}
class OtpEventReSendOtpButton extends OtpEvent {}
