import 'package:cinema_club/features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_movie_from_favorite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_movie_from_favorite_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieFavoriteRepository>()])
void main() {
  late MockMovieFavoriteRepository mockMovieFavoriteRepository;
  late DeleteMovieFromFavorite deleteMovieFromFavorite;

  setUp(() {
    mockMovieFavoriteRepository = MockMovieFavoriteRepository();
    deleteMovieFromFavorite =
        DeleteMovieFromFavorite(repoistories: mockMovieFavoriteRepository);
  });
  const tmovieId = 1;
  test('should return void from the repository', () async {
    when(mockMovieFavoriteRepository.deleteMovieFromFavorite(any))
        .thenAnswer((_) async => const Right(null));
    final result =
        await deleteMovieFromFavorite.deleteMovieFromFavorite(tmovieId);
    expect(result, const Right(null));
    verify(mockMovieFavoriteRepository.deleteMovieFromFavorite(any));
    verifyNoMoreInteractions(mockMovieFavoriteRepository);
  });
}
