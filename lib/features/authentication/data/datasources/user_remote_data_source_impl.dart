import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final DatabaseReference databaseReference;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.databaseReference,
    required this.googleSignIn,
    required this.facebookAuth,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw ServerException('User not found');
      }
    } on FirebaseAuthException {
      throw ServerException('Login failed: the Email or password wrong');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['profile', 'email'],
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;
        if (user != null) {
          return UserModel.fromFirebaseUser(user);
        } else {
          throw ServerException('User not found');
        }
      } else {
        throw ServerException('Google sign-in aborted');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException('Google login failed: ${e.message}');
    }
  }

  @override
  Future<UserModel> loginWithFacebook() async {
    try {
      final LoginResult result = await facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status == LoginStatus.success) {
        print("Facebook login result: ${result.status}");
        final credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;
        if (user != null) {
          return UserModel.fromFirebaseUser(user);
        } else {
          throw ServerException('User not found');
        }
      } else {
        throw ServerException('Facebook login failed: ${result.message}');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException('Facebook login error: ${e.message}');
    }
  }

  @override
  Future<UserModel> signUp(UserModel userModel, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final newUserModel = UserModel(
          uid: user.uid,
          name: userModel.name, // Set the name from the input
          email: user.email ?? '',
          phone: userModel.phone,
          photo: userModel.photo, // Set the phone from the input
          emailVerified: false, // Default to false until verified
        );
        await firebaseAuth.signOut();
        return newUserModel;
      } else {
        throw ServerException('User not found');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException('Sign-up failed: ${e.message}');
    }
  }

  @override
  Future<void> storeUserData(UserModel user) async {
    try {
      final userReference = databaseReference.child('users/${user.uid}');
      final snapshot = await userReference.get();
      if (!snapshot.exists) {
        await userReference.set(user.toJson());
      }
    } on FirebaseException catch (e) {
      throw ServerException('Database error: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();

    if (await googleSignIn.isSignedIn()) {
      try {
        await googleSignIn.disconnect();
      } catch (e) {
        throw ServerException('Sign-out error: ${e.toString()}');
      }
    } else if (await facebookAuth.accessToken != null) {
      try {
        facebookAuth.logOut();
      } catch (e) {
        throw ServerException('Sign-out error: ${e.toString()}');
      }
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException('Password reset failed: ${e.message}');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = firebaseAuth.currentUser!;
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        throw ServerException('User is not logged in or already verified');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException('Email verification failed: ${e.message}');
    }
  }

  @override
  Future<void> updateSendVerificationState() async {
    final user = firebaseAuth.currentUser;
    try {
      if (user != null && user.emailVerified) {
        await databaseReference.child('users/${user.uid}').update({
          'emailVerified': true,
        });
      } else {
        throw ServerException('User is not logged in or email is not verified');
      }
    } catch (e) {
      throw ServerException(
          'Error updating verification state: ${e.toString()}');
    }
  }
}
