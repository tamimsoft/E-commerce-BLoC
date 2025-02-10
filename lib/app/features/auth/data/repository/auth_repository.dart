import 'package:fakestore/app/common/data/models/user_model.dart';
import 'package:fakestore/app/features/auth/data/models/verify_model.dart';

abstract class AuthRepository {
  Future<UserModel> signUp(UserModel user);

  Future<VerifyModel> otpVerify({required String email, required String otp});
  Future<VerifyModel> login({required String email, required String password});

  Future<UserModel> getProfile();

  Future<UserModel> updateProfile(UserModel user);
}
