import 'package:cinema_club/features/authentication/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signUp(UserModel userModel, String password);
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<void> sendEmailVerification();
  Future<void> resetPassword(String email);
  Future<void> storeUserData(UserModel user);
  Future<void> signOut();
  Future<void> updateSendVerificationState();
}
