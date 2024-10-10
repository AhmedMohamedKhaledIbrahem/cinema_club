import 'package:equatable/equatable.dart';

class ProfileUserEntitiy extends Equatable {
  final String name;
  final String email;
  final String photo;
  const ProfileUserEntitiy(
      {required this.name, required this.email, required this.photo});
  @override
  List<Object?> get props => [name, email, photo];
}
