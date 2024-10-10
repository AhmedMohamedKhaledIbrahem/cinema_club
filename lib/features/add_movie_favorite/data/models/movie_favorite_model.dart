import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import 'package:cinema_club/core/converter/genres_converter.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';

@Entity(tableName: 'favoriteMovies')
class MovieFavoriteModel extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int movieId;
  final String orginalTitle;
  final String title;
  final String overView;
  final String tagLine;
  final String relaeaseDate;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  @TypeConverters([GenresConverter])
  final List<GenresModel> geners;

  const MovieFavoriteModel({
    this.id,
    required this.movieId,
    required this.orginalTitle,
    required this.title,
    required this.overView,
    required this.tagLine,
    required this.relaeaseDate,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.geners,
  });

  MovieDetailsModel toDomain() {
    return MovieDetailsModel(
      id: movieId,
      orginalTitle: orginalTitle,
      title: title,
      posterPath: posterPath,
      overView: overView,
      tagLine: tagLine,
      relaeaseDate: relaeaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      geners: geners,
    );
  }

  static MovieFavoriteModel fromDomain(MovieDetailsModel movieDetailsModel) {
    return MovieFavoriteModel(
      movieId: movieDetailsModel.id,
      orginalTitle: movieDetailsModel.orginalTitle,
      title: movieDetailsModel.title,
      overView: movieDetailsModel.overView,
      tagLine: movieDetailsModel.tagLine,
      relaeaseDate: movieDetailsModel.relaeaseDate,
      posterPath: movieDetailsModel.posterPath,
      voteAverage: movieDetailsModel.voteAverage,
      voteCount: movieDetailsModel.voteCount,
      geners: movieDetailsModel.geners.map(
        (genre) {
          return genre is GenresModel
              ? genre
              : GenresModel(id: genre.id, name: genre.name);
        },
      ).toList(),
    );
  }

  factory MovieFavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    return MovieFavoriteModel(
      id: json['id'] as int?,
      movieId: json['movieId'] as int,
      orginalTitle: json['orginalTitle'] as String,
      title: json['title'] as String,
      overView: json['overView'] as String,
      tagLine: json['tagLine'] as String,
      relaeaseDate: json['relaeaseDate'] as String,
      posterPath: json['posterPath'] as String,
      voteAverage: (json['voteAverage'] as num).toDouble(),
      voteCount: json['voteCount'] as int,
      geners: (json['geners'] as List<dynamic>).map((genre) {
        return GenresModel(
          id: genre['id'] as int,
          name: genre['name'] as String,
        );
      }).toList(),
    );
  }

  @override
  List<Object?> get props => [
        movieId,
        orginalTitle,
        title,
        overView,
        tagLine,
        relaeaseDate,
        posterPath,
        voteAverage,
        voteCount,
        geners,
      ];
}
