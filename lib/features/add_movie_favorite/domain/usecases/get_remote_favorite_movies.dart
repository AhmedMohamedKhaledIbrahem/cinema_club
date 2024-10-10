import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:dartz/dartz.dart';

class GetRemoteFavoriteMovies {
  final MovieFavoriteRepository repository;
  const GetRemoteFavoriteMovies({required this.repository});
  Future<Either<Failures, List<MovieFavoriteModel>>>
      getRemoteFavoriteMovies() async {
    return await repository.getRemoteFavoriteMovies();
  }
}
