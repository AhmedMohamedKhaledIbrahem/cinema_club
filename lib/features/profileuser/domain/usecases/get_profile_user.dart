import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:cinema_club/features/profileuser/domain/repositories/profile_user_repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfileUser {
  final ProfileUserRepositories repositories;
  GetProfileUser({required this.repositories});

  Future<Either<Failures, ProfileUserEntitiy>> getProfileUser() async {
    return repositories.getProfileUser();
  }
}
