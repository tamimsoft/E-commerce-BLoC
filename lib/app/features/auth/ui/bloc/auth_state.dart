part of 'auth_bloc.dart';

enum AuthStatus { empty, loading, loadingTexBtn, otpSent, otpReSent, otpVerified, loaded, error }

class AuthState extends Equatable {
  final String email;
  final int remainingTime;
  final String otp;
  final String errorMsg;
  final AuthStatus status;

  const AuthState({
    this.email = '',
    this.remainingTime = 0,
    this.otp = '',
    this.errorMsg = '',
    this.status = AuthStatus.empty,
  });

  AuthState copyWith({String? email, int? remainingTime, String? otp, String? errorMsg, AuthStatus? status}) {
    return AuthState(
      email: email ?? this.email,
      remainingTime: remainingTime ?? this.remainingTime,
      otp: otp ?? this.otp,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? AuthStatus.empty,
    );
  }

  @override
  List<Object> get props => [email, remainingTime, otp, errorMsg, status];
}
