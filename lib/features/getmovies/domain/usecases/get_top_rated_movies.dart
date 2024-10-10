import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedMovies {
  MovieRepository movieRepository;
  GetTopRatedMovies(this.movieRepository);
  Future<Either<Failures, List<Movies>>> getTopRatedMovies() async {
    return await movieRepository.getTopRatedMovies();
  }
}
