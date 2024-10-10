import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieFavoriteRepository {
  Future<Either<Failures, void>> addMovieToFavorite(MovieDetailsEntity movie);
  Future<Either<Failures, void>> deleteMovieFromFavorite(int movieId);
  Future<Either<Failures, List<MovieFavoriteModel>>> getFavoriteMovies();
  Future<Either<Failures, void>> addRemoteMovieToFavorite(
    MovieDetailsEntity movie,
  );
  Future<Either<Failures, void>> deleteRemoteMovieFromFavorite(int movieId);
  Future<Either<Failures, List<MovieFavoriteModel>>> getRemoteFavoriteMovies();
  Future<Either<Failures, void>> deleteAll();
}
