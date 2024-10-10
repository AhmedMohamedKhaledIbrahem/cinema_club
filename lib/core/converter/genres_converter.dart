import 'dart:convert';

import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:floor/floor.dart';

class GenresConverter extends TypeConverter<List<GenresModel>, String> {
/*  List<GenresModel> fromJson(String json) {
    List<dynamic> decode = jsonDecode(json);
    return decode.map((e) => GenresModel.fromJson(e)).toList();
  }

  String toJson(List<GenresModel> genres) {
    List<Map<String, dynamic>> jsonList =
        genres.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }*/

  @override
  List<GenresModel> decode(String databaseValue) {
    final List<dynamic> jsonData = jsonDecode(databaseValue);
    return jsonData.map((e) => GenresModel.fromJson(e)).toList();
  }

  @override
  String encode(List<GenresModel> value) {
    List<Map<String, dynamic>> jsonData = value.map((e) => e.toJson()).toList();
    return jsonEncode(jsonData);
  }
}
