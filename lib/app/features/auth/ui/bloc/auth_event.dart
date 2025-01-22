part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventCheckAuth extends AuthEvent {}

class AuthEventEmailChange extends AuthEvent {
  final String email;

  const AuthEventEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthEventEmailVerifyButton extends AuthEvent {}

class AuthEventReSendEmailVerifyButton extends AuthEvent {}

class AuthEventOtpChange extends AuthEvent {
  final String otp;

  const AuthEventOtpChange({required this.otp});

  @override
  List<Object> get props => [otp];
}

class AuthEventOtpVerifyButton extends AuthEvent {}

