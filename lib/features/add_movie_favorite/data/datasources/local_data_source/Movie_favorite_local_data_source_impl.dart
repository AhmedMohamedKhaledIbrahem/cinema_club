import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_dao.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_local_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';

class MovieFavoriteLocalDataSourceImpl implements MovieFavoriteLocalDataSource {
  final MovieFavoriteDao dao;
  MovieFavoriteLocalDataSourceImpl({required this.dao});

  @override
  Future<void> addMovieToFavorite(MovieDetailsModel moive) async {
    try {
      final entity = MovieFavoriteModel.fromDomain(moive);
      await dao.addMovietoFavorite(entity);
    } catch (e) {
      if (e is CacheException) {
        throw const CacheFaliure('Failed to add movie to favorites locally.');
      } else {
        throw Exception('Unexpected error: $e');
      }
    }
  }

  @override
  Future<void> delteMoviefromFavorite(int movieId) async {
    try {
      await dao.deleteMovieFromFavorite(movieId);
    } catch (e) {
      if (e is CacheException) {
        throw const CacheFaliure(
            'Failed to delete movie from favorites locally.');
      } else {
        throw Exception('Unexpected error: $e');
      }
    }
  }

  @override
  Future<List<MovieFavoriteModel>> getMovies() async {
    try {
      return await dao.getMovies();
    } catch (e) {
      if (e is CacheException) {
        throw const CacheFaliure('Failed to fetch favorite movies locally.');
      } else {
        throw Exception('Unexpected error: $e');
      }
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await dao.deleteAll();
    } catch (e) {
      if (e is CacheException) {
        throw const CacheFaliure(
            'Failed to delete  all movie from favorites locally.');
      } else {
        throw Exception('Unexpected error: $e');
      }
    }
  }
}
