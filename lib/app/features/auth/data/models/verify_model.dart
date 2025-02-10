import 'package:fakestore/app/common/data/models/user_model.dart';

class VerifyModel {
  final String? token;
  final UserModel? user;
  final String? message;

  VerifyModel({
    this.token,
    this.user,
    this.message,
  });

  factory VerifyModel.fromJson(Map<String, dynamic> json) {
    return VerifyModel(
      token: json['token'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null,
      message: json['message'] as String?,
    );
  }
}
