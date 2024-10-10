import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../geners/domain/entities/genresEntities.dart';
import '../entities/movie_search_Entity.dart';
import '../repositories/movie_search_repository.dart';

class MovieSearchUsecase {
  final MovieSearchRepository repository;
  MovieSearchUsecase({required this.repository});

  Future<Either<Failures, List<MovieSearchEntity>>> movieSearch(
      String query, List<GenresEntities> generes) async {
    return repository.movieSearch(query, generes);
  }
}
