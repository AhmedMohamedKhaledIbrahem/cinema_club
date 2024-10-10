import '../models/genres_model.dart';

abstract class GenersRemoteDataSource {
  Future<List<GenresModel>> getGeneres();
}
