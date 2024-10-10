import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failures, UserEntity>> login(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final login = await remoteDataSource.login(email, password);
        return Right(login);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.signOut();
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signUp(
      UserEntity user, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final signUp =
            await remoteDataSource.signUp(user as UserModel, password);
        return Right(signUp);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> storeUserData(UserEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.storeUserData(user as UserModel);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> loginWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final loginWithGoogle = await remoteDataSource.loginWithGoogle();
        return Right(loginWithGoogle);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> loginWithFacebook() async {
    if (await networkInfo.isConnected) {
      try {
        final loginWithFacebook = await remoteDataSource.loginWithFacebook();
        return Right(loginWithFacebook);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> resetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(email);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> sendEmailVerification() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendEmailVerification();
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> updateSendVerificationState() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateSendVerificationState();
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }
}
