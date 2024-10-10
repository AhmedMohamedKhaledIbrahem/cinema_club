import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moivesearch/data/models/movie_search_model.dart';

abstract class MovieSearchRemoteDataSource {
  Future<List<MovieSearchModel>> movieSearch(
      String query, List<GenresEntities> genres);
}
