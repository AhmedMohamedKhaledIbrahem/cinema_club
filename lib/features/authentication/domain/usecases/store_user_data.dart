import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class StoreUserData {
  final UserRepository repository;
  StoreUserData({required this.repository});
  Future<Either<Failures, void>> storeUserData(UserEntity user) async {
    return await repository.storeUserData(user);
  }
}