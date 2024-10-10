import 'dart:convert';

import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieDetailsModel = MovieDetailsModel(
    id: 1,
    orginalTitle: "orginalTitle",
    title: "title",
    posterPath: "posterPath",
    overView: "overView",
    tagLine: "tagLine",
    relaeaseDate: "relaeaseDate",
    voteAverage: 1.0,
    voteCount: 2,
    geners: [
      GenresModel(id: 1, name: "name"),
      GenresModel(id: 2, name: "name2"),
      GenresModel(id: 3, name: "name3")
    ],
  );

  test('should the movieDetailsModel is subClass of Entity', () async {
    expect(tMovieDetailsModel, isA<MovieDetailsEntity>());
  });
  group('from Json', () {
    test('should return a vaild model from json', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('movie_details.json'));
      final result = MovieDetailsModel.fromJson(jsonMap);
      expect(result, tMovieDetailsModel);
    });
  });
}
