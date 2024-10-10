import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/getmovies/data/datasources/movies_remote_data_source.dart';
import 'package:cinema_club/features/getmovies/data/models/movies_model.dart';
import 'package:cinema_club/features/getmovies/data/repositories/movie_repository_impl.dart';
import 'package:cinema_club/features/getmovies/domain/entities/movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<MoviesRemoteDataSource>(),
])
void main() {
  late MovieRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockMoviesRemoteDataSource mockRemoteDataSource;

  setUp(
    () {
      mockNetworkInfo = MockNetworkInfo();
      mockRemoteDataSource = MockMoviesRemoteDataSource();
      repository = MovieRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo,
      );
    },
  );
  group('getMovies', () {
    const tMoviesModel = [
      MoviesModel(
        id: 120,
        name: "name",
        orginalName: "orginalName",
        overView: "overView",
        title: "",
        orginalTitle: "",
        posterPath: "posterPath",
        backDropPath: "backDropPath",
        mediaType: "mediaType",
        orginalLanguage: "orginalLanguage",
        releaseTime: "",
        voteAverage: 7.3,
        voteCount: 234,
        genres: [13, 20],
      )
    ];
    List<Movies> tMoives = tMoviesModel;

    test('should check if the device online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.getMovies();
      verify(mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getMovies())
            .thenAnswer((_) async => tMoviesModel);
        final result = await repository.getMovies();

        expect(result, equals(Right(tMoives)));
        verify(mockRemoteDataSource.getMovies());
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
      test(
          'should return server failure when the call to remote data source is unsucessful',
          () async {
        when(mockRemoteDataSource.getMovies()).thenThrow(ServerException());
        final result = await repository.getMovies();
        verify(mockRemoteDataSource.getMovies());

        expect(result, equals(Left(ServerFaliure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return connection Failure when no internet connection',
          () async {
        //when(mockRemoteDataSource.getMovies()).thenThrow(ServerException());
        final reuslt = await repository.getMovies();
        //verify(mockRemoteDataSource.getMovies());
        expect(reuslt, equals(Left(ConnectionFaliure())));
      });
    });
  });
}
