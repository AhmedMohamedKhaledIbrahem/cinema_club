import 'package:cinema_club/core/errors/failures.dart';

import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoriteMovies {
  final MovieFavoriteRepository repoistories;
  GetFavoriteMovies({required this.repoistories});
  Future<Either<Failures, List<MovieFavoriteModel>>> getFavoriteMovies() async {
    return await repoistories.getFavoriteMovies();
  }
}
