part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupEventOnChangeFirstName extends SignupEvent {
  final String firstName;

  const SignupEventOnChangeFirstName({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class SignupEventOnChangeLastName extends SignupEvent {
  final String lastName;

  const SignupEventOnChangeLastName({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class SignupEventOnChangePhone extends SignupEvent {
  final String phone;

  const SignupEventOnChangePhone({required this.phone});

  @override
  List<Object> get props => [phone];
}

class SignupEventOnChangeCity extends SignupEvent {
  final String city;

  const SignupEventOnChangeCity({required this.city});

  @override
  List<Object> get props => [city];
}

class SignupEventOnChangeEmail extends SignupEvent {
  final String email;

  const SignupEventOnChangeEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class SignupEventOnChangePassword extends SignupEvent {
  final String password;

  const SignupEventOnChangePassword({required this.password});

  @override
  List<Object> get props => [password];
}

class SignupEventSignupButton extends SignupEvent {}
