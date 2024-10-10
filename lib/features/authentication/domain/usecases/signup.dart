import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SignUp {
  final UserRepository repository;
  SignUp({required this.repository});

  Future<Either<Failures, UserEntity>> signUp(
      UserEntity user, String password) async {
    return await repository.signUp(user, password);
  }
}
