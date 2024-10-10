import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetUpcomingMovies {
  final MovieRepository movieRepository;
  GetUpcomingMovies(this.movieRepository);
  Future<Either<Failures, List<Movies>>> getUpcomingMovies() async {
    return await movieRepository.getUpcomingMovies();
  }
}
