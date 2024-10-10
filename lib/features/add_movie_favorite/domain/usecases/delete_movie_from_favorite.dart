import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteMovieFromFavorite {
  final MovieFavoriteRepository repoistories;
  DeleteMovieFromFavorite({required this.repoistories});
  Future<Either<Failures, void>> deleteMovieFromFavorite(int movieId) async {
    return await repoistories.deleteMovieFromFavorite(movieId);
  }
}
