part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventOnChangeEmail extends LoginEvent {
  final String email;

  const LoginEventOnChangeEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginEventOnChangePassword extends LoginEvent {
  final String password;

  const LoginEventOnChangePassword({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginEventLoginButton extends LoginEvent {}
