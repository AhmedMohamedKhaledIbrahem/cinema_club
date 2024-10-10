import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileUserRepositories {
  Future<Either<Failures, ProfileUserEntitiy>> getProfileUser();
  Future<Either<Failures, void>> uploadProfileUserPhoto(String filePath);
}
