import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moivesearch/data/datasources/movie_search_remote_data_source.dart';
import 'package:cinema_club/features/moivesearch/data/models/movie_search_model.dart';
import 'package:cinema_club/features/moivesearch/data/repositories/movie_search_repository_impl.dart';
import 'package:cinema_club/features/moivesearch/domain/entities/movie_search_Entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<MovieSearchRemoteDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockMovieSearchRemoteDataSource mockRemoteDataSource;
  late MovieSearchRepositoryImpl repositoryImpl;
  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockMovieSearchRemoteDataSource();
    repositoryImpl = MovieSearchRepositoryImpl(
        networkInfo: mockNetworkInfo, remoteDataSource: mockRemoteDataSource);
  });
  List<MovieSearchModel> tMovieSearchModel = [
    const MovieSearchModel(
      id: 238,
      orginalTitle: "The Godfather",
      title: "The Godfather",
      posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      overView:
          "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
      relaeaseDate: "1972-03-14",
      voteAverage: 8.69,
      voteCount: 20375,
      generId: [18, 80],
      genresName: ["Drama", "Crime"],
    )
  ];
  const tGenres = [
    GenresModel(id: 18, name: "Drama"),
    GenresModel(id: 80, name: "Crime"),
  ];
  const tQuery = "The Godfather";
  List<MovieSearchEntity> tMovieSearchEntity = tMovieSearchModel;
  test('check if the device online', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    await repositoryImpl.movieSearch(tQuery, tGenres);
    verify(mockNetworkInfo.isConnected);
  });
  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test(
        'should return the remote data when call the remote data source is successful',
        () async {
      when(mockRemoteDataSource.movieSearch(any, any))
          .thenAnswer((_) async => tMovieSearchModel);
      final result = await repositoryImpl.movieSearch(tQuery, tGenres);
      expect(result, equals(Right(tMovieSearchEntity)));
      verify(mockRemoteDataSource.movieSearch(any, any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'should return server failure when the call to remote data source is unsucessful',
        () async {
      when(mockRemoteDataSource.movieSearch(any, any))
          .thenThrow(ServerException());
      final result = await repositoryImpl.movieSearch(tQuery, tGenres);
      verify(mockRemoteDataSource.movieSearch(any, any));
      expect(result, equals(Left(ServerFaliure())));
    });
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
        'should return the remote data when call the remote data source is successful',
        () async {
      final result = await repositoryImpl.movieSearch(tQuery, tGenres);
      expect(result, equals(Left(ConnectionFaliure())));
    });
  });
}
