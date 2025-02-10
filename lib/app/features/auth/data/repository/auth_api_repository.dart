import 'package:fakestore/app/common/data/models/user_model.dart';
import 'package:fakestore/app/core/constants/api_constants.dart';
import 'package:fakestore/app/core/services/network/api_client.dart';
import 'package:fakestore/app/features/auth/data/models/verify_model.dart';

import 'auth_repository.dart';

class AuthApiRepository implements AuthRepository {
  final ApiClient _apiClient;

  AuthApiRepository(this._apiClient);

  @override
  Future<UserModel> signUp(UserModel user) async {
    return await _apiClient.postRequest<UserModel>(
      endpoint: ApiConstants.signUp,
      fromJson: (json) => UserModel.fromJson(json),
      body: user.toJson(),
    );
  }

  @override
  Future<VerifyModel> otpVerify({required String email, required String otp}) async {
    Map<String, dynamic> map = {
      'email': email,
      'otp': otp,
    };
    return await _apiClient.postRequest<VerifyModel>(
      endpoint: ApiConstants.otpVerify,
      fromJson: (json) => VerifyModel.fromJson(json),
      body: map,
    );
  }

  @override
  Future<VerifyModel> login({required String email, required String password}) async {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
    };
    return await _apiClient.postRequest<VerifyModel>(
      endpoint: ApiConstants.login,
      fromJson: (json) => VerifyModel.fromJson(json),
      body: map,
    );
  }

  @override
  Future<UserModel> getProfile() async {
    return await _apiClient.getRequest<UserModel>(
      endpoint: ApiConstants.profile,
      fromJson: (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    return await _apiClient.getRequest<UserModel>(
      endpoint: ApiConstants.profile,
      fromJson: (json) => UserModel.fromJson(json),
    );
  }
}
