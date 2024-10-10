import '../../../geners/domain/entities/genresEntities.dart';
import '../../domain/entities/movie_search_Entity.dart';

class MovieSearchModel extends MovieSearchEntity {
  const MovieSearchModel({
    required super.id,
    required super.orginalTitle,
    required super.title,
    required super.posterPath,
    required super.overView,
    required super.relaeaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.generId,
    required super.genresName,
  });
  factory MovieSearchModel.fromJson(
      Map<String, dynamic> json, List<GenresEntities> genres) {
    //! create the genreMap from GenresEntities
    final genreMap = {
      for (GenresEntities genre in genres) genre.id: genre.name
    };

    //! replace genre IDs with genre Names
    final genreNames = (json['genre_ids'] as List)
        .map((id) => genreMap[id] ?? 'Unkoun')
        .toList();

    return MovieSearchModel(
      id: json['id'] ?? 0,
      overView: json['overview'] ?? '',
      title: json['title'] ?? '',
      orginalTitle: json['original_title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      relaeaseDate: json['release_date'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      generId: List<int>.from(json['genre_ids']),
      genresName: genreNames,
    );
  }
}
