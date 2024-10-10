import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_exception.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/movies_remote_data_source.dart';
import '../../domain/entities/movies.dart';
import '../../domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

typedef _AllOrTopRatedOrPopulrOrUpcomingChooser = Future<List<Movies>>
    Function();

class MovieRepositoryImpl implements MovieRepository {
  List<Movies> getMovieById = [];
  final MoviesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, List<Movies>>> getMovies() async {
    return await _getMovies(() {
      return remoteDataSource.getMovies();
    });
  }

  @override
  Future<Either<Failures, List<Movies>>> getPopularMovies() async {
    return await _getMovies(() {
      return remoteDataSource.getPopularMovies();
    });
  }

  @override
  Future<Either<Failures, List<Movies>>> getTopRatedMovies() async {
    return await _getMovies(() {
      return remoteDataSource.getTopRatedMovies();
    });
  }

  @override
  Future<Either<Failures, List<Movies>>> getUpcomingMovies() async {
    return await _getMovies(() {
      return remoteDataSource.getUpcomingMovies();
    });
  }

  Future<Either<Failures, List<Movies>>> _getMovies(
      _AllOrTopRatedOrPopulrOrUpcomingChooser
          getAllOrTopRatedOrPopulrOrUpcoming) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await getAllOrTopRatedOrPopulrOrUpcoming();
        return Right(movies);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, Movies>> findMovieById(int id) {
    final resulr = remoteDataSource.getMovies() as List;
    return resulr.firstWhere((movie) => movie.id == id);
  }
}
