import 'dart:convert';

import 'package:cinema_club/constants/string/api.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moivesearch/data/datasources/movie_search_remote_data_source.dart';
import 'package:cinema_club/features/moivesearch/data/models/movie_search_model.dart';
import 'package:dio/dio.dart';

class MovieSearchRemoteDataSourceImpl implements MovieSearchRemoteDataSource {
  final Dio dio;
  MovieSearchRemoteDataSourceImpl({required this.dio});
  int pageNumber = 1;

  @override
  Future<List<MovieSearchModel>> movieSearch(
      String query, List<GenresEntities> genres) async {
    final String url = buildMovieSearchApi(query, pageNumber);
    final Map<String, dynamic> headerss = {'Authorization': header};
    //bool hasMorePages = true;
    final response = await dio.get(url, options: Options(headers: headerss));
    if (response.statusCode == 200 /*&& hasMorePages == true*/) {
      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;
      if (data.containsKey('results') && data['results'] is List) {
        List<MovieSearchModel> movieSearchList =
            (data['results'] as List<dynamic>)
                .map((movieSearchjson) =>
                    MovieSearchModel.fromJson(movieSearchjson, genres))
                .toList();
        //hasMorePages = pageNumber < data['total_pages'];
        //pageNumber++;
        print(data);
        return movieSearchList;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
