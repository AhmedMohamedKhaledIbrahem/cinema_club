import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/geners/data/datasources/geners_remote_data_source.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/geners/data/repositories/geners_repository_impl.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'genres_repository_Impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<GenersRemoteDataSource>(),
])
void main() {
  late GenersRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockGenersRemoteDataSource mockGenersRemoteDataSource;

  setUp(
    () {
      mockNetworkInfo = MockNetworkInfo();
      mockGenersRemoteDataSource = MockGenersRemoteDataSource();
      repository = GenersRepositoryImpl(
        genersRemoteDataSource: mockGenersRemoteDataSource,
        networkInfo: mockNetworkInfo,
      );
    },
  );

  group('getGenres', () {
    const tgenresModel = [
      GenresModel(id: 35, name: 'Comedy'),
      GenresModel(id: 14, name: 'Fantasy'),
      GenresModel(id: 27, name: 'Horror'),
    ];
    const List<GenresEntities> tgenresEntitiy = tgenresModel;
    test('should check if the device online ', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.getGeneres();
      verify(mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        },
      );
      test(
          'should return the remote data when the call remote data source is successful',
          () async {
        when(mockGenersRemoteDataSource.getGeneres()).thenAnswer(
          (_) async => tgenresModel,
        );
        final result = await repository.getGeneres();
        verify(mockGenersRemoteDataSource.getGeneres());
        expect(result, equals(const Right(tgenresEntitiy)));
      });
      test(
          'should return the severFailure when the call remote data source is unsuccessful',
          () async {
        when(mockGenersRemoteDataSource.getGeneres())
            .thenThrow(ServerException());
        final result = await repository.getGeneres();
        verify(mockGenersRemoteDataSource.getGeneres());
        expect(result, equals(Left(ServerFaliure())));
      });
    });
    group('device is offline', () {
      setUp(
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        },
      );
      test('should return the ConeectionFailure when no internet Connection',
          () async {
        final result = await repository.getGeneres();
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
}
