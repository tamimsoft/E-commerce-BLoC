import 'package:ecommerce2/app/features/auth/data/repository/auth_api_repository.dart';
import 'package:ecommerce2/app/utils/secure_storage/secure_storage.dart';

class AuthService {
  final AuthApiRepository _authApiRepository;

  final SecureStorage _storage = SecureStorage();

  AuthService(this._authApiRepository);

  Future<bool> isAuthenticated() async {
    return _storage.read(key: SSKey.token).then((token) => token.isNotEmpty);
  }

  Future<bool> sendEmailVerification({required String email}) async {
    try {
      await _storage.clearAll();
      await _authApiRepository.emailVerify(email);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> otpVerify({required String email, required String otp}) async {
    try {
      String token = await _authApiRepository.otpVerify(email, otp);
      await _storage.write(key: SSKey.token, value: token);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
