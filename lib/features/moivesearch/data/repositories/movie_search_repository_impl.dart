import 'package:cinema_club/features/moivesearch/data/datasources/movie_search_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_exception.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../../../core/network/network_info.dart';
import '../../../geners/domain/entities/genresEntities.dart';
import '../../domain/entities/movie_search_Entity.dart';
import '../../domain/repositories/movie_search_repository.dart';

class MovieSearchRepositoryImpl implements MovieSearchRepository {
  MovieSearchRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  MovieSearchRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failures, List<MovieSearchEntity>>> movieSearch(
      String query, List<GenresEntities> generes) async {
    if (await networkInfo.isConnected) {
      try {
        final movieSearch = await remoteDataSource.movieSearch(query, generes);
        return Right(movieSearch);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }
}
