import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failures, List<Movies>>> getMovies();
  Future<Either<Failures, List<Movies>>> getUpcomingMovies();
  Future<Either<Failures, List<Movies>>> getTopRatedMovies();
  Future<Either<Failures, List<Movies>>> getPopularMovies();
  Future<Either<Failures, Movies>> findMovieById(int id);
}
