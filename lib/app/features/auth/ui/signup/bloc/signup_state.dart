part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String city;
  final Status status;
  final String errorMsg;

  const SignupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.city = '',
    this.status = Status.initial,
    this.errorMsg = '',
  });

  SignupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? city,
    Status? status,
    String? errorMsg,
  }) {
    return SignupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email, password, phone, city, status, errorMsg];
}
