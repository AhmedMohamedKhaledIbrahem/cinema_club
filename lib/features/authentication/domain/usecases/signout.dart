import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class Signout {
  final UserRepository repository;
  Signout({required this.repository});
  Future<Either<Failures, void>> signOut() async {
    return await repository.signOut();
  }
}
