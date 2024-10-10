import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieFavoriteModel', () {
    final genres = [const GenresModel(id: 1, name: 'Action')];
    final tMovieDetails = MovieDetailsModel(
      id: 1,
      orginalTitle: 'Original Title',
      title: 'Title',
      posterPath: '/path/to/poster',
      overView: 'Overview',
      tagLine: 'Tagline',
      relaeaseDate: '2024-10-06',
      voteAverage: 8.5,
      voteCount: 1000,
      geners: genres,
    );

    final tMovieFavorite = MovieFavoriteModel(
      id: 1,
      movieId: 1,
      orginalTitle: 'Original Title',
      title: 'Title',
      overView: 'Overview',
      tagLine: 'Tagline',
      relaeaseDate: '2024-10-06',
      posterPath: '/path/to/poster',
      voteAverage: 8.5,
      voteCount: 1000,
      geners: genres,
    );

    test('should convert from domain model correctly', () {
      final result = MovieFavoriteModel.fromDomain(tMovieDetails);
      expect(result, tMovieFavorite);
    });

    test('should convert to domain model correctly', () {
      final result = tMovieFavorite.toDomain();
      expect(result, tMovieDetails);
    });
  });
}
