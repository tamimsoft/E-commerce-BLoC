part of 'otp_bloc.dart';

enum Status { empty, loading, loaded, error }

class OtpState extends Equatable {
  final String email;
  final String otp;
  final int remainingTime;
  final Status status;
  final String errorMsg;

  const OtpState({
    this.email = '',
    this.otp = '',
    this.remainingTime = 0,
    this.status = Status.empty,
    this.errorMsg = '',
  });

  OtpState copyWith({
    String? email,
    String? otp,
    int? remainingTime,
    Status? status,
    String? errorMsg,
  }) {
    return OtpState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [email, otp, remainingTime, status, errorMsg];
}
