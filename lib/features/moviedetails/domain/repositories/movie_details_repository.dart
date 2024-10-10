import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/movie_details_Entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failures, MovieDetailsEntity>> movieDetailsById(int id);
}
