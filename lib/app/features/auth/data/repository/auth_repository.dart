abstract class AuthRepository {
  Future<void> emailVerify(String email);
  Future<String> otpVerify(String email, String otp);
}
