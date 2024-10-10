import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../constants/string/api.dart';
import '../../../../constants/string/string.dart';
import '../../../../core/errors/server_exception.dart';
import '../models/movies_model.dart';
import 'movies_remote_data_source.dart';

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  late Dio dio;
  int pageNumber = 1;

  MoviesRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<MoviesModel>> getMovies() => _getMoviesFromUrl(getAllMoviesApi);
  @override
  Future<List<MoviesModel>> getPopularMovies() =>
      _getMoviesFromUrl(getPopularApi);

  @override
  Future<List<MoviesModel>> getTopRatedMovies() =>
      _getMoviesFromUrl(getTopRatedAPi);

  @override
  Future<List<MoviesModel>> getUpcomingMovies() =>
      _getMoviesFromUrl(getUpComingSoonApi);

  Future<List<MoviesModel>> _getMoviesFromUrl(String linkUrl) async {
    final String url = '$linkUrl$pageNumber';
    final Map<String, dynamic> headerss = {'Authorization': header};
    bool hasMorePages = true;
    final response = await dio.get(url, options: Options(headers: headerss));

    if (response.statusCode == 200 && hasMorePages == true) {
      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;
      if (data.containsKey('results') && data['results'] is List) {
        List<MoviesModel> pageMoviesList = (data['results'] as List<dynamic>)
            .map((movieJson) =>
                MoviesModel.fromJson(movieJson as Map<String, dynamic>))
            .toList();

        hasMorePages = pageNumber < data['total_pages'];
        pageNumber++;
        return pageMoviesList;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
