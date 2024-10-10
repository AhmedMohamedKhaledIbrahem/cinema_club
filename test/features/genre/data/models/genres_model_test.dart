import 'dart:convert';

import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tgenresModel = [
    GenresModel(id: 35, name: 'Comedy'),
    GenresModel(id: 14, name: 'Fantasy'),
    GenresModel(id: 27, name: 'Horror'),
  ];

  test('should be subclass of the genres Entity', () async {
    expect(tgenresModel, isA<List<GenresEntities>>());
  });

  group(
    'fromJson',
    () {
      final jsonMap =
          json.decode(fixture('genres.json')) as Map<String, dynamic>;
      test('should return the vaild list of model from json', () {
        final List<GenresModel> result = (jsonMap['genres'] as List)
            .map((genresJson) => GenresModel.fromJson(genresJson))
            .toList();
        expect(result, tgenresModel);
      });
    },
  );
}
