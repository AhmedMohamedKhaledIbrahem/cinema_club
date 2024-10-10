import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.uid,
      required super.name,
      required super.email,
      required super.phone,
      required super.photo,
      required super.emailVerified});

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'userName': name,
      'email': email,
      'phone': phone,
      'profilePhoto': photo,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      name: json['userName'],
      email: json['email'],
      phone: json['phone'],
      photo: json['profilePhoto'],
      emailVerified: json['emailVerified'],
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? 'Unknown Name',
      email: user.email ?? 'Email',
      phone: user.phoneNumber ?? 'Unknown Phone',
      photo: user.photoURL ?? 'No Profile Photo',
      emailVerified: user.emailVerified,
    );
  }

  factory UserModel.fromModel(UserModel user) {
    return UserModel(
      uid: user.uid,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photo: user.photo,
      emailVerified: user.emailVerified,
    );
  }
}
