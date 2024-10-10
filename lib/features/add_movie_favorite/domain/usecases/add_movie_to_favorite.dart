import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';

class AddMovieToFavorite {
  final MovieFavoriteRepository repoistories;
  AddMovieToFavorite({required this.repoistories});
  Future<Either<Failures, void>> addMovieToFavorite(
      MovieDetailsEntity moive) async {
    return await repoistories.addMovieToFavorite(moive);
  }
}
