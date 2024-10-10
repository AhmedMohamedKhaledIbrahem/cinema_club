import '../../../geners/data/models/genres_model.dart';
import '../../domain/entities/movie_details_Entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.id,
    required super.orginalTitle,
    required super.title,
    required super.posterPath,
    required super.overView,
    required super.tagLine,
    required super.relaeaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.geners,
  });
  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      overView: json['overview'] ?? '',
      title: json['title'] ?? '',
      orginalTitle: json['original_title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      relaeaseDate: json['release_date'] ?? '',
      tagLine: json['tagline'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      geners: (json['genres'] as List<dynamic>?)
              ?.map((genre) =>
                  GenresModel.fromJson(genre as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
