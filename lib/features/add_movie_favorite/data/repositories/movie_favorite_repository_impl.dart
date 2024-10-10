import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_local_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/remote_data_source/movie_favorite_remote_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';

class MovieFavoriteRepositoryImpl implements MovieFavoriteRepository {
  final MovieFavoriteLocalDataSource localDataSource;
  final MovieFavoriteRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  MovieFavoriteRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, void>> addMovieToFavorite(
      MovieDetailsEntity movie) async {
    try {
      if (movie is MovieDetailsModel) {
        await localDataSource.addMovieToFavorite(movie);
        return const Right(null);
      } else {
        throw Exception('Invalid type');
      }
    } on CacheException {
      return const Left(CacheFaliure('Failed to cache the movie data.'));
    }
  }

  @override
  Future<Either<Failures, void>> deleteMovieFromFavorite(int movieId) async {
    try {
      await localDataSource.delteMoviefromFavorite(movieId);
      return const Right(null);
    } on CacheException {
      return const Left(
          CacheFaliure('Failed to delete movie from favorites locally.'));
    }
  }

  @override
  Future<Either<Failures, List<MovieFavoriteModel>>> getFavoriteMovies() async {
    try {
      final getFavoriteMovies = await localDataSource.getMovies();
      return Right(getFavoriteMovies);
    } on CacheException {
      return const Left(CacheFaliure('Failed to retrieve favorite movies.'));
    }
  }

  @override
  Future<Either<Failures, void>> addRemoteMovieToFavorite(
      MovieDetailsEntity movie) async {
    if (await networkInfo.isConnected) {
      try {
        if (movie is MovieDetailsModel) {
          final movieFavoriteModel = MovieFavoriteModel.fromDomain(movie);
          await remoteDataSource.addRemoteMovieToFavorite(movieFavoriteModel);
        }
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteRemoteMovieFromFavorite(
      int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteRemoteMovieFromFavorite(movieId);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, List<MovieFavoriteModel>>>
      getRemoteFavoriteMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataSource.getRemoteFavoriteMovies();
        /**/ for (var movie in movies) {
          // Convert MovieFavoriteModel to MovieDetailsModel before saving
          final movieDetailsModel =
              movie.toDomain(); // Assuming toDomain() converts it
          await localDataSource
              .addMovieToFavorite(movieDetailsModel); // Save each movie
        }
        return right(movies);
      } on ServerException catch (e) {
        return Left(ServerFaliure(e.message));
      }
    } else {
      return const Left(ConnectionFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteAll() async {
    try {
      await localDataSource.deleteAll();
      return const Right(null);
    } on CacheException {
      return const Left(
          CacheFaliure('Failed to delete movie from favorites locally.'));
    }
  }
}
