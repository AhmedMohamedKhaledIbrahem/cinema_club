import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteRemoteMovieToFavoirte {
  final MovieFavoriteRepository repository;
  const DeleteRemoteMovieToFavoirte({required this.repository});
  Future<Either<Failures, void>> deleteRemoteMovieFromFavorite(
      int movieId) async {
    return await repository.deleteRemoteMovieFromFavorite(movieId);
  }
}
