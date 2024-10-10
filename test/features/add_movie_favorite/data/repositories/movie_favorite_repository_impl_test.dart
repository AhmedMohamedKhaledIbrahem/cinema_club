import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/core/network/network_info.dart';

import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_local_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/remote_data_source/movie_favorite_remote_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/data/repositories/movie_favorite_repository_impl.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_favorite_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MovieFavoriteLocalDataSource>(),
  MockSpec<MovieFavoriteRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
void main() {
  late MockMovieFavoriteLocalDataSource mockLocalDataSource;
  late MockMovieFavoriteRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MovieFavoriteRepositoryImpl repository;
  setUp(() {
    mockLocalDataSource = MockMovieFavoriteLocalDataSource();
    mockRemoteDataSource = MockMovieFavoriteRemoteDataSource();
    mockNetworkInfo=MockNetworkInfo();
    repository =
        MovieFavoriteRepositoryImpl(localDataSource: mockLocalDataSource,networkInfo: mockNetworkInfo,remoteDataSource: mockRemoteDataSource);
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
    test('should return void when the call to local data source is successful',
        () async {
      when(mockLocalDataSource.addMovieToFavorite(any))
          .thenAnswer((_) async => Future.value());

      final result = await repository.addMovieToFavorite(tmovieDetails);

      verify(mockLocalDataSource.addMovieToFavorite(tmovieDetails));
      expect(result, equals(const Right(null)));
    });

    test('should return CacheFaliure when there is a CacheException', () async {
      when(mockLocalDataSource.addMovieToFavorite(any))
          .thenThrow(CacheException());

      final result = await repository.addMovieToFavorite(tmovieDetails);

      verify(mockLocalDataSource.addMovieToFavorite(tmovieDetails));
      expect(result, equals(const Left(CacheFaliure())));
    });
  });

  group('deleteMovieFromFavorite', () {
    test('should return void when the call to local data source is successful',
        () async {
      when(mockLocalDataSource.delteMoviefromFavorite(any))
          .thenAnswer((_) async => Future.value());

      final result = await repository.deleteMovieFromFavorite(1);

      verify(mockLocalDataSource.delteMoviefromFavorite(1));
      expect(result, equals(const Right(null)));
    });

    test('should return CacheFaliure when there is a CacheException', () async {
      when(mockLocalDataSource.delteMoviefromFavorite(any))
          .thenThrow(CacheException());

      final result = await repository.deleteMovieFromFavorite(1);

      verify(mockLocalDataSource.delteMoviefromFavorite(1));
      expect(result, equals(const Left(CacheFaliure())));
    });
  });

  group('getFavoriteMovies', () {
    final tmovieFavoriteList = [tmovieFavorite];

    test(
        'should return movieList when the call to local data source is successful',
        () async {
      when(mockLocalDataSource.getMovies())
          .thenAnswer((_) async => tmovieFavoriteList);

      final result = await repository.getFavoriteMovies();

      verify(mockLocalDataSource.getMovies());
      expect(result, equals(Right(tmovieFavoriteList)));
    });

    test('should return CacheFaliure when there is a CacheException', () async {
      when(mockLocalDataSource.getMovies()).thenThrow(CacheException());

      final result = await repository.getFavoriteMovies();

      verify(mockLocalDataSource.getMovies());
      expect(result, equals(const Left(CacheFaliure())));
    });
  });
}
