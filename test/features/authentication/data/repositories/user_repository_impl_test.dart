import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/core/network/network_info.dart';
import 'package:cinema_club/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:cinema_club/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<UserRemoteDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockUserRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password';
  const tUserModel = UserModel(
    uid: '123',
    name: 'Test User',
    email: 'test@example.com',
    phone: '1234567890',
    photo: "",
    emailVerified: false,
  );
  void deviceOnline(MockNetworkInfo mockNetworkInfo) {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void deviceOffline(MockNetworkInfo mockNetworkInfo) {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  group('login', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.login(tEmail, tPassword);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return user when the call to remote data source is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.login(any, any))
            .thenAnswer((_) async => tUserModel);
        final result = await repository.login(tEmail, tPassword);
        verify(mockUserRemoteDataSource.login(any, any));
        expect(result, equals(const Right(tUserModel)));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.login(any, any))
            .thenThrow(ServerException());
        final result = await repository.login(tEmail, tPassword);
        verify(mockUserRemoteDataSource.login(any, any));
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure ', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.login(tEmail, tPassword);
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
  group('signUp', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.signUp(tUserModel, tPassword);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return user when the call to remote data source is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.signUp(any, any))
            .thenAnswer((_) async => tUserModel);
        final result = await repository.signUp(tUserModel, tPassword);
        verify(mockUserRemoteDataSource.signUp(any, any));
        expect(result, equals(const Right(tUserModel)));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.signUp(any, any))
            .thenThrow(ServerException());
        final result = await repository.signUp(tUserModel, tPassword);
        verify(mockUserRemoteDataSource.signUp(any, any));
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.signUp(tUserModel, tPassword);
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });

  group('signout', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.signOut();
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test('should call remote data source to sign out is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.signOut()).thenAnswer((_) async {});
        final result = await repository.signOut();
        verify(mockUserRemoteDataSource.signOut());
        expect(result, equals(const Right(null)));
      });

      test(
          'should return ServerFailure when the call remote data source to sign out is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.signOut()).thenThrow(ServerException());
        final result = await repository.signOut();
        verify(mockUserRemoteDataSource.signOut());
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.signOut();
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
  group('storeUserData', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.storeUserData(tUserModel);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test('should call remote data source to store user data when online',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.storeUserData(any))
            .thenAnswer((_) async => Future.value());
        await repository.storeUserData(tUserModel);
        verify(mockUserRemoteDataSource.storeUserData(any));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.storeUserData(any))
            .thenThrow(ServerException());
        final result = await repository.storeUserData(tUserModel);
        verify(mockUserRemoteDataSource.storeUserData(any));
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.storeUserData(tUserModel);
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });

  group('loginWithGoogle', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.loginWithGoogle();
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return user when the call to remote data source is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.loginWithGoogle())
            .thenAnswer((_) async => tUserModel);
        final result = await repository.loginWithGoogle();
        verify(mockUserRemoteDataSource.loginWithGoogle());
        expect(result, equals(const Right(tUserModel)));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.loginWithGoogle())
            .thenThrow(ServerException());
        final result = await repository.loginWithGoogle();
        verify(mockUserRemoteDataSource.loginWithGoogle());
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.loginWithGoogle();
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });

  group('loginWithFacebook', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.loginWithGoogle();
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return user when the call to remote data source is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.loginWithFacebook())
            .thenAnswer((_) async => tUserModel);
        final result = await repository.loginWithFacebook();
        verify(mockUserRemoteDataSource.loginWithFacebook());
        expect(result, equals(const Right(tUserModel)));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.loginWithFacebook())
            .thenThrow(ServerException());
        final result = await repository.loginWithFacebook();
        verify(mockUserRemoteDataSource.loginWithFacebook());
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.loginWithFacebook();
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
  group('sendEmailVerification', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.sendEmailVerification();
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should call remote data source to sendEmailVerification is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.sendEmailVerification())
            .thenAnswer((_) async {});
        final result = await repository.sendEmailVerification();
        verify(mockUserRemoteDataSource.sendEmailVerification());
        expect(result, equals(const Right(null)));
      });

      test(
          'should return ServerFailure when the call remote data source to sendEmailVerification is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.sendEmailVerification())
            .thenThrow(ServerException());
        final result = await repository.sendEmailVerification();
        verify(mockUserRemoteDataSource.sendEmailVerification());
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.sendEmailVerification();
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });

  group('resetPassword', () {
    test('check if the  device online', () async {
      deviceOnline(mockNetworkInfo);
      await repository.resetPassword(tEmail);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test('should call remote data source to resetPassword is successful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.resetPassword(any))
            .thenAnswer((_) async {});
        final result = await repository.resetPassword(tEmail);
        verify(mockUserRemoteDataSource.resetPassword(any));
        expect(result, equals(const Right(null)));
      });

      test(
          'should return ServerFailure when the call remote data source to resetPassword is unsuccessful',
          () async {
        deviceOnline(mockNetworkInfo);
        when(mockUserRemoteDataSource.resetPassword(any))
            .thenThrow(ServerException());
        final result = await repository.resetPassword(tEmail);
        verify(mockUserRemoteDataSource.resetPassword(any));
        expect(result, equals(Left(ServerFaliure())));
      });
      test('should return ConnectionFailure when the device offline', () async {
        deviceOffline(mockNetworkInfo);
        final result = await repository.resetPassword(tEmail);
        verifyZeroInteractions(mockUserRemoteDataSource);
        expect(result, equals(Left(ConnectionFaliure())));
      });
    });
  });
}
