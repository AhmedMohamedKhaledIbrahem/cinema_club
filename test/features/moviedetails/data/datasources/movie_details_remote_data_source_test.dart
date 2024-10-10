import 'dart:convert';

import 'package:cinema_club/constants/string/api.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/moviedetails/data/datasources/movie_details_remote_data_source_impl.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../movies/data/datasources/movies_reomte_date_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late MockDio mockDio;
  late MovieDetailsRemoteDataSourceImpl movieDetailsRemoteDataSourceImpl;

  setUp(
    () {
      mockDio = MockDio();
      movieDetailsRemoteDataSourceImpl =
          MovieDetailsRemoteDataSourceImpl(dio: mockDio);
    },
  );

  group('movieDetailsByid', () {
    int tid = 917496;
    String url = "$movieDetailsByApi$tid";
    final Map<String, dynamic> headerss = {'Authorization': header};
    final MovieDetailsModel tsearchMovieModel = MovieDetailsModel.fromJson(
        json.decode(fixture('movie_details_real.json')));

    test('should return movie when the response code is 200 ', () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: fixture('movie_details_real.json'),
          statusCode: 200,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final result =
          await movieDetailsRemoteDataSourceImpl.movieDetailsById(tid);
      expect(result, equals(tsearchMovieModel));
    });

    test(
        'should return ServerExecption when the response code is 404 or other ',
        () async {
      when(mockDio.get(url, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: url, headers: headerss),
        ),
      );
      final call = movieDetailsRemoteDataSourceImpl.movieDetailsById;
      expect(() => call(tid), throwsA(isA<ServerException>()));
    });
  });
}
