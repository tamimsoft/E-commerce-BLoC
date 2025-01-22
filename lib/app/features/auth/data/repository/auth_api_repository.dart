import 'package:ecommerce2/app/utils/constants/api_constants.dart';
import 'package:ecommerce2/app/utils/network/api_client.dart';

import 'auth_repository.dart';

class AuthApiRepository implements AuthRepository {
  final ApiClient _apiClient;

  AuthApiRepository(this._apiClient);

  @override
  Future<void> emailVerify(String email) async {
    await _apiClient.getRequest(endpoint: ApiConstants.emailVerify(email), fromJson: (_) {});
  }

  @override
  Future<String> otpVerify(String email, String otp) async {
    return await _apiClient.getRequest<String>(
      endpoint: ApiConstants.otpVerify(email, otp),
      fromJson: (t) => t.toString(),
    );
  }
}
