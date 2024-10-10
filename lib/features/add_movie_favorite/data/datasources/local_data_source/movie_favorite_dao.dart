import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieFavoriteDao {
  @Query('SELECT * FROM favoriteMovies')
  Future<List<MovieFavoriteModel>> getMovies();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addMovietoFavorite(MovieFavoriteModel moive);

  @Query('DELETE FROM favoriteMovies WHERE movieId = :movieId')
  Future<void> deleteMovieFromFavorite(int movieId);

  @Query('Delete From favoriteMovies')
  Future<void> deleteAll();
}
