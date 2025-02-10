import 'package:fakestore/app/common/data/models/user_model.dart';
import 'package:fakestore/app/core/services/secure_storage/secure_storage.dart';
import 'package:fakestore/app/features/auth/data/models/verify_model.dart';
import 'package:fakestore/app/features/auth/data/repository/auth_api_repository.dart';

class AuthService {
  final AuthApiRepository _authApiRepository;

  final SecureStorage _storage = SecureStorage();

  AuthService(this._authApiRepository);

  Future<bool> isAuthenticated() async {
    return _storage.read(key: SSKey.token).then((token) => token.isNotEmpty);
  }

  Future<bool> signUp({required UserModel user}) async {
    try {
      await _storage.clearAll();
      final UserModel userModel = await _authApiRepository.signUp(user);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      await _storage.clearAll();
      final VerifyModel verifyModel = await _authApiRepository.login(email: email, password: password);
      final String token = verifyModel.token ?? '';
      if (token.isEmpty) {
        return false;
      }
      await _storage.write(key: SSKey.token, value: token);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> otpVerify({required String email, required String otp}) async {
    try {
      final VerifyModel verifyModel = await _authApiRepository.otpVerify(email: email, otp: otp);
      final String token = verifyModel.token ?? '';
      if (token.isEmpty) {
        return false;
      }
      await _storage.write(key: SSKey.token, value: token);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
