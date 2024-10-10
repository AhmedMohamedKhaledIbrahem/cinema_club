import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final UserRepository repository;
  Login({required this.repository});
  Future<Either<Failures, UserEntity>> login(
      String email, String password) async {
    return await repository.login(email, password);
  }
}
