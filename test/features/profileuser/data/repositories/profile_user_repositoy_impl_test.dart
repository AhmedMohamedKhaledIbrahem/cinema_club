import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/profileuser/data/datasources/profile_user_remote_data_source.dart';
import 'package:cinema_club/features/profileuser/data/models/profile_user_model.dart';
import 'package:cinema_club/features/profileuser/data/repositories/profile_user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_user_repositoy_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<ProfileUserRemoteDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockProfileUserRemoteDataSource mockProfileUserRemoteDataSource;
  late ProfileUserRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockProfileUserRemoteDataSource = MockProfileUserRemoteDataSource();
    repositoryImpl = ProfileUserRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockProfileUserRemoteDataSource);
  });
  void deviceOnline(MockNetworkInfo mockNetworkInfo) {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void deviceOffline(MockNetworkInfo mockNetworkInfo) {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  group('getProfileUser', () {
    const tProfileUserModel = ProfileUserModel(
      name: "John Doe",
      email: "johndoe@example.com",
      photo: "empty",
    );
    test('check if the device online', () async {
      deviceOnline(mockNetworkInfo);
      await repositoryImpl.getProfileUser();
      verify(mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      test(
          'should return the ProfileUser when call remote data Source is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockProfileUserRemoteDataSource.getProfileUser())
            .thenAnswer((_) async => tProfileUserModel);
        final result = await repositoryImpl.getProfileUser();
        verify(mockProfileUserRemoteDataSource.getProfileUser());
        expect(result, equals(const Right(tProfileUserModel)));
      });
      test(
          'should return the SeverFauiler when call remote data Source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockProfileUserRemoteDataSource.getProfileUser())
            .thenThrow(ServerException());
        final result = await repositoryImpl.getProfileUser();
        verify(mockProfileUserRemoteDataSource.getProfileUser());
        expect(result, equals(Left(ServerFaliure())));
      });
    });
    group('device is offline', () {
      test('should return the ConnectionFailure when the device offlinel',
          () async {
        deviceOffline(mockNetworkInfo);
        final result = await repositoryImpl.getProfileUser();
        verifyNoMoreInteractions(mockProfileUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
}
