import 'package:equatable/equatable.dart';

import '../../../geners/domain/entities/genresEntities.dart';

class MovieDetailsEntity extends Equatable {
  final int id;
  final String orginalTitle;
  final String title;
  final String overView;
  final String tagLine;
  final String relaeaseDate;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final List<GenresEntities> geners;

  const MovieDetailsEntity({
    required this.id,
    required this.orginalTitle,
    required this.title,
    required this.posterPath,
    required this.overView,
    required this.tagLine,
    required this.relaeaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.geners,
  });

  @override
  List<Object?> get props => [
        id,
        orginalTitle,
        title,
        posterPath,
        overView,
        tagLine,
        relaeaseDate,
        voteAverage,
        voteCount,
        geners,
      ];
}
