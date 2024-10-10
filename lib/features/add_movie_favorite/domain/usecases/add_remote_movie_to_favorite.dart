import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';

class AddRemoteMovieToFavorite {
  final MovieFavoriteRepository repository;
  AddRemoteMovieToFavorite({required this.repository});
  Future<Either<Failures, void>> addRemoteMovieToFavorite(
      MovieDetailsEntity movie) async {
    return await repository.addRemoteMovieToFavorite(movie);
  }
}
