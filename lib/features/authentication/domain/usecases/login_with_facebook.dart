import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginWithFacebook {
  final UserRepository repository;
  LoginWithFacebook({required this.repository});
  Future<Either<Failures, UserEntity>> loginWithFacebook() async {
    return await repository.loginWithFacebook();
  }
}
