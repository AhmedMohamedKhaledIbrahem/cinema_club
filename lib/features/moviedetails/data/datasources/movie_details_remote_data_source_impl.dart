import 'dart:convert';

import '../../../../constants/string/api.dart';
import '../../../../constants/string/string.dart';
import '../../../../core/errors/server_exception.dart';
import 'movie_details_remote_data_source.dart';
import '../models/movie_details_model.dart';

import 'package:dio/dio.dart';

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final Dio dio;
  MovieDetailsRemoteDataSourceImpl({required this.dio});
  @override
  Future<MovieDetailsModel> movieDetailsById(int id) async {
    final String url = '$movieDetailsByApi$id';
    final Map<String, dynamic> headerss = {'Authorization': header};
    final response = await dio.get(url, options: Options(headers: headerss));
    if (response.statusCode == 200) {
      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;
      return MovieDetailsModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
