import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';

abstract class MovieFavoriteLocalDataSource {
  Future<void> addMovieToFavorite(MovieDetailsModel moive);
  Future<void> delteMoviefromFavorite(int movieId);
  Future<void> deleteAll();
  Future<List<MovieFavoriteModel>> getMovies();
}
