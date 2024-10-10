import 'dart:convert';

import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
      uid: "abc123",
      name: "John Doe",
      email: "johndoe@example.com",
      phone: "1234567890",
      photo: "empty",
      emailVerified: false);
  final Map<String, dynamic> tMapJson = json.decode(fixture('user.json'));
  group('UserModel', () {
    test('should be subclass of UserEntity', () async {
      expect(tUserModel, isA<UserEntity>());
    });
    test('should return a vaild model from Json', () async {
      final result = UserModel.fromJson(tMapJson);
      expect(result, tUserModel);
    });

    test('should return a valid Json map from the model', () async {
      final result = tUserModel.toJson();
      expect(result, tMapJson);
    });
  });
}
