import 'dart:convert';

import 'package:cinema_club/constants/string/api.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/geners/data/datasources/geners_remote_data_source_impl.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'genres_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late GenersRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(
    () {
      mockDio = MockDio();
      dataSource = GenersRemoteDataSourceImpl(dio: mockDio);
    },
  );
  group('getGenres', () {
    final String url = genersApi;
    final Map<String, dynamic> headerss = {'Authorization': header};
    final jsonMap = json.decode(fixture('genres.json')) as Map<String, dynamic>;
    final List<GenresModel> tgenresList = (jsonMap['genres'] as List)
        .map((genresMap) => GenresModel.fromJson(genresMap))
        .toList();

    test('should return the list of genres when response code is 200',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: fixture('genres.json'),
          statusCode: 200,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final result = await dataSource.getGeneres();
      expect(result, equals(tgenresList));
    });

    test('should return server Exption when response code is 404 or other ',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final call = dataSource.getGeneres();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
