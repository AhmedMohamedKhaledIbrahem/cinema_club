import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/profileuser/domain/repositories/profile_user_repositories.dart';
import 'package:dartz/dartz.dart';

class UploadProfileUserPhoto {
  final ProfileUserRepositories repositories;
  const UploadProfileUserPhoto({required this.repositories});
  Future<Either<Failures, void>> uploadProfileUserPhoto(String filePath) async {
    return await repositories.uploadProfileUserPhoto(filePath);
  }
}
