import 'dart:convert';

import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moivesearch/data/models/movie_search_model.dart';
import 'package:cinema_club/features/moivesearch/domain/entities/movie_search_Entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieSearchModel = MovieSearchModel(
    id: 238,
    orginalTitle: "The Godfather",
    title: "The Godfather",
    posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
    overView:
        "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
    relaeaseDate: "1972-03-14",
    voteAverage: 8.69,
    voteCount: 20375,
    generId: [18, 80],
    genresName: ["Drama", "Crime"],
  );
  const tGenres = [
    GenresModel(id: 18, name: "Drama"),
    GenresModel(id: 80, name: "Crime"),
  ];

  test('should be subClass of MovieSearchModel', () async {
    expect(tMovieSearchModel, isA<MovieSearchEntity>());
  });
  test('should return the vaild model from the json', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('movie_search.json'));
    final result = MovieSearchModel.fromJson(jsonMap, tGenres);
    expect(result, tMovieSearchModel);
  });
}
