import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginWithGoogle {
  final UserRepository repository;
  LoginWithGoogle({required this.repository});
  Future<Either<Failures, UserEntity>> loginWithGoogle() async {
    return await repository.loginWithGoogle();
  }
}
