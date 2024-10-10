import 'package:equatable/equatable.dart';

class MovieSearchEntity extends Equatable {
  final int id;
  final String orginalTitle;
  final String title;
  final String overView;
  final String relaeaseDate;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final List<int> generId;
  final List<String> genresName;
  const MovieSearchEntity({
    required this.id,
    required this.orginalTitle,
    required this.title,
    required this.posterPath,
    required this.overView,
    required this.relaeaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.generId,
    required this.genresName,
  });

  @override
  List<Object?> get props => [
        id,
        orginalTitle,
        title,
        posterPath,
        overView,
        relaeaseDate,
        voteAverage,
        voteCount,
        generId,
        genresName,
      ];
}
