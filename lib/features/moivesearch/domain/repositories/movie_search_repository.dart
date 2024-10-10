import '../../../../core/errors/failures.dart';
import '../../../geners/domain/entities/genresEntities.dart';
import '../entities/movie_search_Entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieSearchRepository {
  Future<Either<Failures, List<MovieSearchEntity>>> movieSearch(
      String query, List<GenresEntities> generes);
}
