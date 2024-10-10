import 'dart:async';
import 'package:cinema_club/core/converter/genres_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:cinema_club/features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_dao.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:floor/floor.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [MovieFavoriteModel])
abstract class AppDatabase extends FloorDatabase {
  MovieFavoriteDao get dao;
}
