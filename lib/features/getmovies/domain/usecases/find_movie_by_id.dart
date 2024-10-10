import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class FindMovieById {
  final MovieRepository movieRepository;
  FindMovieById(this.movieRepository);
  Future<Either<Failures, Movies>> findMovieById(int id) {
    return movieRepository.findMovieById(id);
  }
}
