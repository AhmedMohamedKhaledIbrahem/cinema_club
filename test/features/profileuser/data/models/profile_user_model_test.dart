import 'dart:convert';

import 'package:cinema_club/features/profileuser/data/models/profile_user_model.dart';
import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tProfileUserModel = ProfileUserModel(
    name: "John Doe",
    email: "johndoe@example.com",
    photo: "empty",
  );

  group('ProfileModel', () {
    final Map<String, dynamic> tMapJson =
        json.decode(fixture('profile_user.json'));
    test('should the ProfileUserModel is subclass of ProfileUserEntitiy',
        () async {
      expect(tProfileUserModel, isA<ProfileUserEntitiy>());
    });
    test('should return the vaild Model from Json', () async {
      final result = ProfileUserModel.fromJson(tMapJson);
      expect(result, tProfileUserModel);
    });
  });
}
