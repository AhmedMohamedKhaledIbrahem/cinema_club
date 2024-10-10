import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateSendVerificationstate {
  final UserRepository repository;
  const UpdateSendVerificationstate({required this.repository});
  Future<Either<Failures, void>> updateSendVerificationState() async {
    return await repository.updateSendVerificationState();
  }
}
