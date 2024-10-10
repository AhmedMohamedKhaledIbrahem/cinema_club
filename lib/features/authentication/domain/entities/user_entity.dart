import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final bool emailVerified;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [uid, name, email, phone, photo, emailVerified];
}
