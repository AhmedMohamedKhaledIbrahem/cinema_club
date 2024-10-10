import 'dart:io';

import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/profileuser/data/datasources/profile_user_remote_data_source.dart';
import 'package:cinema_club/features/profileuser/data/models/profile_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileUserRemoteDataSourceImpl implements ProfileUserRemoteDataSource {
  final FirebaseDatabase firebaseDatabase;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;
  ProfileUserRemoteDataSourceImpl({
    required this.firebaseDatabase,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<ProfileUserModel> getProfileUser() async {
    final firebaseReference = firebaseDatabase.ref();
    final userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      final dataSnapshot = await firebaseReference.child('users/$userId').get();

      if (dataSnapshot.exists) {
        final Map<String, dynamic> profileData =
            Map<String, dynamic>.from(dataSnapshot.value as Map);
        final profileUserModel = ProfileUserModel.fromJson(profileData);
        return profileUserModel;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> uploadProfileUserPhoto(String filePath) async {
    final firebaseReference = firebaseDatabase.ref();
    final firebaseStorageReference = firebaseStorage.ref();
    final userId = firebaseAuth.currentUser?.uid;
    if (filePath.isNotEmpty) {
      final file = File(filePath);
      final storageRef = firebaseStorageReference.child(
        'userPhotos/${file.uri.pathSegments.last}',
      );
      final uploadTask = storageRef.putFile(file);
      final snapShot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapShot.ref.getDownloadURL();
      if (userId != null) {
        await firebaseReference.child('users/$userId').update(
          {
            'profilePhoto': downloadUrl,
          },
        );
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
