import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAll {
  final MovieFavoriteRepository repository;
  const DeleteAll({required this.repository});
  Future<Either<Failures, void>> deleteAll() async {
    return await repository.deleteAll();
  }
}
