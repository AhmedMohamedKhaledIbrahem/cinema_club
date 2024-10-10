import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_movie_to_favorite.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_movie_to_favorite_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieFavoriteRepository>()])
void main() {
  late MockMovieFavoriteRepository mockMovieFavoriteRepository;
  late AddMovieToFavorite addMovieToFavorite;

  setUp(() {
    mockMovieFavoriteRepository = MockMovieFavoriteRepository();
    addMovieToFavorite =
        AddMovieToFavorite(repoistories: mockMovieFavoriteRepository);
  });

  const tgenresEntity = [
    GenresEntities(id: 1, name: "action"),
    GenresEntities(id: 2, name: "comady")
  ];
  const tMovieDetialsEntity = MovieDetailsEntity(
    id: 1,
    orginalTitle: "orginalTitle",
    title: "title",
    posterPath: "posterPath",
    overView: "overView",
    tagLine: "tagLine",
    relaeaseDate: "relaeaseDate",
    voteAverage: 3.0,
    voteCount: 3,
    geners: tgenresEntity,
  );

  test('should return void from the repository', () async {
    when(mockMovieFavoriteRepository.addMovieToFavorite(any))
        .thenAnswer((_) async => const Right(null));
    final result =
        await addMovieToFavorite.addMovieToFavorite(tMovieDetialsEntity);
    expect(result, const Right(null));
    verify(mockMovieFavoriteRepository.addMovieToFavorite(any));
    verifyNoMoreInteractions(mockMovieFavoriteRepository);
  });
}
