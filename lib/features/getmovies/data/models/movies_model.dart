import '../../domain/entities/movies.dart';

class MoviesModel extends Movies {
  const MoviesModel(
      {required super.id,
      required super.name,
      required super.orginalName,
      required super.overView,
      required super.title,
      required super.orginalTitle,
      required super.posterPath,
      required super.backDropPath,
      required super.mediaType,
      required super.orginalLanguage,
      required super.releaseTime,
      required super.voteAverage,
      required super.voteCount,
      required super.genres});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      orginalName: json['original_name'] ?? '',
      overView: json['overview'] ?? '',
      title: json['title'] ?? '',
      orginalTitle: json['original_title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backDropPath: json['backdrop_path'] ?? '',
      mediaType: json['media_type'] ?? '',
      orginalLanguage: json['original_language'] ?? '',
      releaseTime: json['release_date'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      genres: (json['genre_ids'] as List<dynamic>?)?.cast<int>() ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backDropPath;
    data['id'] = id;
    data['name'] = name;
    data['original_name'] = orginalName;
    data['overview'] = overView;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['original_language'] = orginalLanguage;
    data['genre_ids'] = genres;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['title'] = title;
    data['original_title'] = orginalTitle;
    data['release_date'] = releaseTime;
    return data;
  }
}
