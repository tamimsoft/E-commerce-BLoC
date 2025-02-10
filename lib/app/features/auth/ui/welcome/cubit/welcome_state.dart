part of 'welcome_cubit.dart';

enum Status { initial, loading, loaded, error }

class WelcomeState extends Equatable {
  final Status status;
  final bool isAuthenticated;
  final String? errorMsg;

  const WelcomeState({
    this.status = Status.initial,
    this.isAuthenticated = false,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [status, errorMsg];

  WelcomeState copyWith({
    Status? status,
    bool? isAuthenticated,
    String? errorMsg,
  }) {
    return WelcomeState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
