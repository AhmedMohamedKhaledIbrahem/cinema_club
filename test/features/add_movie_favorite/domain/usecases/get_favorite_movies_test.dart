import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_favorite_movies.dart';
import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_favorite_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieFavoriteRepository>()])
void main() {
  late MockMovieFavoriteRepository mockMovieFavoriteRepository;
  late GetFavoriteMovies getFavoriteMovies;
  setUp(() {
    mockMovieFavoriteRepository = MockMovieFavoriteRepository();
    getFavoriteMovies =
        GetFavoriteMovies(repoistories: mockMovieFavoriteRepository);
  });
  const tgenresEntity = [
    GenresModel(id: 1, name: "action"),
    GenresModel(id: 2, name: "comady")
  ];

  final tMovieFavoriteModel = [
    MovieFavoriteModel(
      id: 1,
      movieId: 1,
      orginalTitle: "orginalTitle",
      overView: "overView",
      posterPath: "posterPath",
      relaeaseDate: "relaeaseDate",
      tagLine: "tagLine",
      title: "title",
      voteAverage: 1.2,
      voteCount: 2,
      geners: tgenresEntity,
    ),
    MovieFavoriteModel(
      id: 2,
      movieId: 3,
      orginalTitle: "orginalTitle2",
      overView: "overView2",
      posterPath: "posterPath2",
      relaeaseDate: "relaeaseDate2",
      tagLine: "tagLine2",
      title: "title2",
      voteAverage: 1.2,
      voteCount: 2,
      geners: tgenresEntity,
    )
  ];
  test('should retrun list of MovieFavoriteModel from the repository',
      () async {
    when(mockMovieFavoriteRepository.getFavoriteMovies())
        .thenAnswer((_) async => Right(tMovieFavoriteModel));
    final result = await getFavoriteMovies.getFavoriteMovies();
    expect(result, Right(tMovieFavoriteModel));
    verify(mockMovieFavoriteRepository.getFavoriteMovies());
    verifyNoMoreInteractions(mockMovieFavoriteRepository);
  });
}
