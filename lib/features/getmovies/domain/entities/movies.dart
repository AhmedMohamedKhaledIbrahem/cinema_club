import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  final int id;
  final String name;
  final String orginalName;
  final String overView;
  final String title;
  final String orginalTitle;
  final String posterPath;
  final String backDropPath;
  final String mediaType;
  final String orginalLanguage;
  final String releaseTime;
  final double voteAverage;
  final int voteCount;
  final List<int> genres;

  const Movies({
    required this.id,
    required this.name,
    required this.orginalName,
    required this.overView,
    required this.title,
    required this.orginalTitle,
    required this.posterPath,
    required this.backDropPath,
    required this.mediaType,
    required this.orginalLanguage,
    required this.releaseTime,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        orginalName,
        overView,
        title,
        orginalTitle,
        orginalLanguage,
        posterPath,
        backDropPath,
        mediaType,
        releaseTime,
        voteAverage,
        voteCount,
        genres,
      ];
}
