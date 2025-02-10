part of 'login_bloc.dart';

enum Status { empty, loading, loaded, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final Status status;
  final String errorMsg;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = Status.empty,
    this.errorMsg = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
    Status? status,
    String? errorMsg,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [email, password, status, errorMsg];
}
