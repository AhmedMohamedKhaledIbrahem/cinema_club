import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_exception.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/geners_remote_data_source.dart';
import '../../domain/entities/genresEntities.dart';
import '../../domain/repositories/genre_repository.dart';
import 'package:dartz/dartz.dart';

class GenersRepositoryImpl implements GenreRepository {
  final GenersRemoteDataSource genersRemoteDataSource;
  final NetworkInfo networkInfo;
  GenersRepositoryImpl(
      {required this.genersRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, List<GenresEntities>>> getGeneres() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGeners = await genersRemoteDataSource.getGeneres();
        return Right(remoteGeners);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }
}
