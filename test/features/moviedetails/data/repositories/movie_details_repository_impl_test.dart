import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moviedetails/data/datasources/movie_details_remote_data_source.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:cinema_club/features/moviedetails/data/repositories/movie_details_repository_impl.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_details_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<MovieDetailsRemoteDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockMovieDetailsRemoteDataSource mockMovieDetailsRemoteDataSource;
  late MovieDetailsRepositoryImpl repositoryImpl;

  setUp(
    () {
      mockNetworkInfo = MockNetworkInfo();
      mockMovieDetailsRemoteDataSource = MockMovieDetailsRemoteDataSource();
      repositoryImpl = MovieDetailsRepositoryImpl(
          networkInfo: mockNetworkInfo,
          movieDetailsRemoteDataSource: mockMovieDetailsRemoteDataSource);
    },
  );

  group('movieDetailsById', () {
    const tid = 1;
    const tMovieDetailsModel = MovieDetailsModel(
      id: 1,
      orginalTitle: "orginalTitle",
      title: "title",
      posterPath: "posterPath",
      overView: "overView",
      tagLine: "tagLine",
      relaeaseDate: "relaeaseDate",
      voteAverage: 1.0,
      voteCount: 2,
      geners: [
        GenresModel(id: 1, name: "name"),
        GenresModel(id: 2, name: "name2"),
        GenresModel(id: 3, name: "name3")
      ],
    );
    const MovieDetailsEntity tMovieDetailsEntity = tMovieDetailsModel;
    test('should check if the device is online ', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repositoryImpl.movieDetailsById(tid);
      verify(mockNetworkInfo.isConnected);
    });
    group('device is online ', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockMovieDetailsRemoteDataSource.movieDetailsById(tid))
            .thenAnswer((_) async => tMovieDetailsModel);
        final result = await repositoryImpl.movieDetailsById(tid);
        expect(result, equals(const Right(tMovieDetailsEntity)));
        verify(mockMovieDetailsRemoteDataSource.movieDetailsById(tid));
        verifyNoMoreInteractions(mockMovieDetailsRemoteDataSource);
      });

      test(
          'should return ServerFailure when the call to remote data source is unsccessful',
          () async {
        when(mockMovieDetailsRemoteDataSource.movieDetailsById(tid))
            .thenThrow(ServerException());
        final result = await repositoryImpl.movieDetailsById(tid);
        verify(mockMovieDetailsRemoteDataSource.movieDetailsById(tid));
        expect(result, equals(Left(ServerFaliure())));
      });
    });

    group('device is online ', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return the serverFailure when no internet connection',
          () async {
        final result = await repositoryImpl.movieDetailsById(tid);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
}
