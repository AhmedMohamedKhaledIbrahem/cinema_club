import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failures, UserEntity>> login(String email, String password);
  Future<Either<Failures, UserEntity>> loginWithGoogle();
  Future<Either<Failures, UserEntity>> loginWithFacebook();
  Future<Either<Failures, void>> sendEmailVerification();
  Future<Either<Failures, void>> resetPassword(String email);
  Future<Either<Failures, UserEntity>> signUp(UserEntity user, String password);
  Future<Either<Failures, void>> storeUserData(UserEntity user);
  Future<Either<Failures, void>> signOut();
  Future<Either<Failures, void>> updateSendVerificationState();
}
