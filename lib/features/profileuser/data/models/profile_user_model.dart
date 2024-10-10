import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';

class ProfileUserModel extends ProfileUserEntitiy {
  const ProfileUserModel({
    required super.name,
    required super.email,
    required super.photo,
  });
  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
        name: json['userName'],
        email: json["email"],
        photo: json["profilePhoto"]);
  }
}
