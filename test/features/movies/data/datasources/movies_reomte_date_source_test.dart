import 'dart:convert';

import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/getmovies/data/datasources/movies_remote_data_source_impl.dart';
import 'package:cinema_club/features/getmovies/data/models/movies_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'movies_reomte_date_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late MoviesRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(
    () {
      mockDio = MockDio();
      dataSource = MoviesRemoteDataSourceImpl(dio: mockDio);
    },
  );

  group('getMovies', () {
    const url =
        'https://api.themoviedb.org/3/trending/movie/week?language=en-US&page=1';
    final Map<String, dynamic> headerss = {'Authorization': header};
    final List<MoviesModel> tMoviesList =
        (json.decode(fixture('movies_list.json'))['results'] as List)
            .map((movieJson) => MoviesModel.fromJson(movieJson))
            .toList();

    test('should return list of movies when the response code is 200',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
          (_) async => Response(
              data: fixture('movies_list.json'),
              statusCode: 200,
              requestOptions: RequestOptions(path: url, headers: headerss)));

      final result = await dataSource.getMovies();
      expect(result, equals(tMoviesList));
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final call = dataSource.getMovies();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
