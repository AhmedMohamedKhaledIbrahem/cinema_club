import 'package:dartz/dartz.dart';

import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_exception.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie_details_Entity.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../datasources/movie_details_remote_data_source.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;
  final NetworkInfo networkInfo;
  MovieDetailsRepositoryImpl(
      {required this.networkInfo, required this.movieDetailsRemoteDataSource});

  @override
  Future<Either<Failures, MovieDetailsEntity>> movieDetailsById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final movieDetailsMovie =
            await movieDetailsRemoteDataSource.movieDetailsById(id);
        return Right(movieDetailsMovie);
      } on ServerException {
        return left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }
}
