import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularMovies {
  MovieRepository movieRepository;
  GetPopularMovies(this.movieRepository);
  Future<Either<Failures, List<Movies>>> getPopularMovies() async {
    return await movieRepository.getPopularMovies();
  }
}
