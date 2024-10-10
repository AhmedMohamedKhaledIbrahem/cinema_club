import 'dart:convert';

import 'package:cinema_club/constants/string/api.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moivesearch/data/datasources/movie_search_remote_data_source_impl.dart';
import 'package:cinema_club/features/moivesearch/data/models/movie_search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'movie_search_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late MockDio mockDio;
  late MovieSearchRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    remoteDataSourceImpl = MovieSearchRemoteDataSourceImpl(dio: mockDio);
  });

  group('movieSearch', () {
    const tQuery = "The Godfather";
    const pageNumber = 1;
    const tGenresModel = [
      GenresModel(id: 18, name: "Action"),
      GenresModel(id: 80, name: "Adventure")
    ];
    String url = buildMovieSearchApi(tQuery, pageNumber);
    final Map<String, dynamic> headerss = {'Authorization': header};
    final List<MovieSearchModel> tMovieSearchModel =
        (json.decode(fixture('movie_search_list.json'))['results'] as List)
            .map((jsonMap) => MovieSearchModel.fromJson(jsonMap, tGenresModel))
            .toList();

    test('should return list of MovieSearch when the response code is 200',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: fixture('movie_search_list.json'),
          statusCode: 200,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final result =
          await remoteDataSourceImpl.movieSearch(tQuery, tGenresModel);
      expect(result, equals(tMovieSearchModel));
    });

    test(
        'should throw the ServerException when the response code is 404 or other',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final call = remoteDataSourceImpl.movieSearch(tQuery, tGenresModel);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
