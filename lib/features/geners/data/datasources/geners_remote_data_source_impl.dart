import 'dart:convert';

import '../../../../constants/string/api.dart';
import '../../../../constants/string/string.dart';
import '../../../../core/errors/server_exception.dart';
import 'geners_remote_data_source.dart';
import '../models/genres_model.dart';
import 'package:dio/dio.dart';

class GenersRemoteDataSourceImpl implements GenersRemoteDataSource {
  final Dio dio;
  GenersRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GenresModel>> getGeneres() async {
    final String url = genersApi;
    final Map<String, dynamic> headerss = {'Authorization': header};
    final response = await dio.get(url, options: Options(headers: headerss));
    if (response.statusCode == 200) {
      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      if (data.containsKey('genres') && data['genres'] is List) {
        List<GenresModel> genresList = (data['genres'] as List<dynamic>)
            .map((genreJson) =>
                GenresModel.fromJson(genreJson as Map<String, dynamic>))
            .toList();
        return genresList;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
