import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SendEmailVerification {
  final UserRepository repository;
  SendEmailVerification({required this.repository});
  Future<Either<Failures, void>> sendEmailVerification() async {
    return await repository.sendEmailVerification();
  }
}
