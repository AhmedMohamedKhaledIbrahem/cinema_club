import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/movie_details_Entity.dart';
import '../repositories/movie_details_repository.dart';

class MovieDetailsUsecase {
  final MovieDetailsRepository repository;
  MovieDetailsUsecase({required this.repository});
  Future<Either<Failures, MovieDetailsEntity>> movieDetailsById(int id) {
    return repository.movieDetailsById(id);
  }
}
