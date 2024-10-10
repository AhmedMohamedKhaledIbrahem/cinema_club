import 'dart:convert';

import 'package:cinema_club/features/getmovies/data/models/movies_model.dart';
import 'package:cinema_club/features/getmovies/domain/entities/movies.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMoviesModel = MoviesModel(
    id: 120,
    name: "name",
    orginalName: "orginalName",
    overView: "overView",
    title: "",
    orginalTitle: "",
    posterPath: "posterPath",
    backDropPath: "backDropPath",
    mediaType: "mediaType",
    orginalLanguage: "orginalLanguage",
    releaseTime: "",
    voteAverage: 7.3,
    voteCount: 234,
    genres: [13, 20],
  );
  test('should be subclass of movies Entity', () async {
    expect(tMoviesModel, isA<Movies>());
  });
  group('fromJson', () {
    test('should return a vaild model from json', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('movies.json'));
      final result = MoviesModel.fromJson(jsonMap);
      expect(result, tMoviesModel);
    });
  });
}
