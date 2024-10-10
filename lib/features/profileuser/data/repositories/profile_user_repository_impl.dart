import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/profileuser/data/datasources/profile_user_remote_data_source.dart';
import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:cinema_club/features/profileuser/domain/repositories/profile_user_repositories.dart';
import 'package:dartz/dartz.dart';

class ProfileUserRepositoryImpl implements ProfileUserRepositories {
  final NetworkInfo networkInfo;
  final ProfileUserRemoteDataSource remoteDataSource;
  ProfileUserRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failures, ProfileUserEntitiy>> getProfileUser() async {
    if (await networkInfo.isConnected) {
      try {
        final getProfileUser = await remoteDataSource.getProfileUser();
        return Right(getProfileUser);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> uploadProfileUserPhoto(String filePath) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.uploadProfileUserPhoto(filePath);
        return const Right(null);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }
}
