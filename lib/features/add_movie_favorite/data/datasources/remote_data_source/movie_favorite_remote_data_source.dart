import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';

abstract class MovieFavoriteRemoteDataSource {
  Future<void> addRemoteMovieToFavorite(MovieFavoriteModel movie);
  Future<void> deleteRemoteMovieFromFavorite(int movieId);
  Future<List<MovieFavoriteModel>> getRemoteFavoriteMovies();
}
