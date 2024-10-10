import '../../../../core/errors/failures.dart';
import '../entities/movies.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMoives {
  final MovieRepository movieRepository;
  GetMoives(this.movieRepository);

  Future<Either<Failures, List<Movies>>> getAllMovies() async {
    return await movieRepository.getMovies();
  }
}
