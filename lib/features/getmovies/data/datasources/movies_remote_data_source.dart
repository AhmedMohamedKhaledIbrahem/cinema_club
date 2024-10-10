import '../models/movies_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MoviesModel>> getMovies();
  Future<List<MoviesModel>> getPopularMovies();
  Future<List<MoviesModel>> getTopRatedMovies();
  Future<List<MoviesModel>> getUpcomingMovies();
}
