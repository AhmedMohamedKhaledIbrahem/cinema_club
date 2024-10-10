import '../../../../core/errors/failures.dart';
import '../entities/genresEntities.dart';
import 'package:dartz/dartz.dart';

abstract class GenreRepository {
  Future<Either<Failures, List<GenresEntities>>> getGeneres();
}
