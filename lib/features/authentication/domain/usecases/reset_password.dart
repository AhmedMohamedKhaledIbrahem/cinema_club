import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPassword {
  final UserRepository repository;
  ResetPassword({required this.repository});
  Future<Either<Failures, void>> resetPassword(String email) async {
    return await repository.resetPassword(email);
  }
}
