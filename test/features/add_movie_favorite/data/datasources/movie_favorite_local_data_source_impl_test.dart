import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/Movie_favorite_local_data_source_impl.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_dao.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_favorite_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieFavoriteDao>()])
void main() {
  late MockMovieFavoriteDao mockMovieFavoriteDao;
  late MovieFavoriteLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockMovieFavoriteDao = MockMovieFavoriteDao();
    localDataSourceImpl =
        MovieFavoriteLocalDataSourceImpl(dao: mockMovieFavoriteDao);
  });
  const tgenresEntity = [
    GenresEntities(id: 1, name: "action"),
    GenresEntities(id: 2, name: "comady")
  ];
  const tmovieDetails = MovieDetailsModel(
    id: 1,
    orginalTitle: 'Original Title',
    title: 'Title',
    posterPath: '/path/to/poster',
    overView: 'Overview',
    tagLine: 'Tagline',
    relaeaseDate: '2024-10-06',
    voteAverage: 8.5,
    voteCount: 1000,
    geners: tgenresEntity,
  );

  final tmovieFavorite = MovieFavoriteModel.fromDomain(tmovieDetails);
  group('addMovieToFavorite', () {
    test('should call dao to add Movie to favorite ', () async {
      when(mockMovieFavoriteDao.addMovietoFavorite(any))
          .thenAnswer((_) async => Future.value());
      await localDataSourceImpl.addMovieToFavorite(tmovieDetails);
      verify(mockMovieFavoriteDao.addMovietoFavorite(tmovieFavorite));
    });
    test('should throw CacheFailure when there is a CacheException', () async {
      when(mockMovieFavoriteDao.addMovietoFavorite(any))
          .thenThrow(CacheException());

      final call = localDataSourceImpl.addMovieToFavorite;

      expect(() => call(tmovieDetails), throwsA(isA<CacheFaliure>()));
    });
  });
  group('deleteMoviefromFavorite', () {
    test('should call dao to delete movie from favorite', () async {
      // arrange
      when(mockMovieFavoriteDao.deleteMovieFromFavorite(any))
          .thenAnswer((_) async => Future.value());

      // act
      await localDataSourceImpl.delteMoviefromFavorite(1);

      // assert
      verify(mockMovieFavoriteDao.deleteMovieFromFavorite(1));
    });

    test('should throw CacheFailure when there is a CacheException', () async {
      // arrange
      when(mockMovieFavoriteDao.deleteMovieFromFavorite(any))
          .thenThrow(CacheException());

      // act
      final call = localDataSourceImpl.delteMoviefromFavorite;

      // assert
      expect(() => call(1), throwsA(isA<CacheFaliure>()));
    });
  });

  group('getMovies', () {
    final movieList = [tmovieFavorite];

    test('should call dao to get movies', () async {
      // arrange
      when(mockMovieFavoriteDao.getMovies()).thenAnswer((_) async => movieList);

      // act
      final result = await localDataSourceImpl.getMovies();

      // assert
      verify(mockMovieFavoriteDao.getMovies());
      expect(result, movieList);
    });

    test('should throw CacheFailure when there is a CacheException', () async {
      // arrange
      when(mockMovieFavoriteDao.getMovies()).thenThrow(CacheException());

      // act
      final call = localDataSourceImpl.getMovies;

      // assert
      expect(() => call(), throwsA(isA<CacheFaliure>()));
    });
  });
}
