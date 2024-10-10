import 'package:cinema_club/features/profileuser/data/models/profile_user_model.dart';

abstract class ProfileUserRemoteDataSource {
  Future<ProfileUserModel> getProfileUser();
  Future<void> uploadProfileUserPhoto(String filePath);
}
