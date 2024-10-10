import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/genresEntities.dart';
import '../repositories/genre_repository.dart';

class GetGenreUseCase {
  final GenreRepository repository;
  GetGenreUseCase({required this.repository});
  Future<Either<Failures, List<GenresEntities>>> getGeneres() async {
    return await repository.getGeneres();
  }
}
