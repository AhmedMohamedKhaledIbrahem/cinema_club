import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/authentication/data/datasources/user_remote_data_source_impl.dart';
import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  DatabaseReference,
  UserCredential,
  User,
  GoogleSignIn,
  FacebookAuth
])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockDatabaseReference mockDatabaseReference;
  late MockUserCredential mockUserCredential;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFacebookAuth mockFacebookAuth;
  late MockUser mockUser;
  late UserRemoteDataSourceImpl dataSource;
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockDatabaseReference = MockDatabaseReference();
    mockUserCredential = MockUserCredential();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFacebookAuth = MockFacebookAuth();
    mockUser = MockUser();
    dataSource = UserRemoteDataSourceImpl(
        firebaseAuth: mockFirebaseAuth,
        databaseReference: mockDatabaseReference,
        googleSignIn: mockGoogleSignIn,
        facebookAuth: mockFacebookAuth);
  });
  const tEmail = 'test@example.com';
  const tPassword = 'testPassword';
  const tUid = 'uid123';
  const tName = 'Test User';
  const tPhone = '123456789';
  const tPhoto = '';
  const tEmailVerified = false;
  const tUserModel = UserModel(
      uid: tUid,
      name: tName,
      email: tEmail,
      phone: tPhone,
      photo: tPhoto,
      emailVerified: false);
  group('login', () {
    test('should return userModel when login is successful', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(tUid);
      when(mockUser.displayName).thenReturn(tName);
      when(mockUser.email).thenReturn(tEmail);
      when(mockUser.phoneNumber).thenReturn(tPhone);
      when(mockUser.photoURL).thenReturn(tPhoto);
      when(mockUser.emailVerified).thenReturn(tEmailVerified);
      final result = await dataSource.login(tEmail, tPassword);
      expect(result, tUserModel);
    });
    test('should throw serverException when login fails', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(code: 'ERROR'));
      final call = dataSource.login(tEmail, tPassword);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('sign up', () {
    test('should return userModel when sign up is successful', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(tUid);
      when(mockUser.displayName).thenReturn(tName);
      when(mockUser.email).thenReturn(tEmail);
      when(mockUser.phoneNumber).thenReturn(tPhone);
      when(mockUser.emailVerified).thenReturn(tEmailVerified);
      final result = await dataSource.signUp(tUserModel, tPassword);
      expect(result, tUserModel);
    });
    test('should throw serverException when sign up fails', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(code: 'ERROR'));
      final call = dataSource.signUp(tUserModel, tPassword);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('storeUserData', () {
    test('should call DatabaseReference to store user data', () async {
      when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);

      await dataSource.storeUserData(tUserModel);

      verify(mockDatabaseReference.child('users/$tUid')).called(1);
      verify(mockDatabaseReference.set(tUserModel.toJson())).called(1);
    });
  });
  test('should throw ServerException when storeUserData fails', () async {
    when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);
    when(mockDatabaseReference.set(any))
        .thenThrow(FirebaseException(plugin: 'Firebase'));

    expect(() => dataSource.storeUserData(tUserModel),
        throwsA(isA<ServerException>()));
  });
}
