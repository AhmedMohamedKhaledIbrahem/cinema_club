import 'package:cinema_club/features/getmovies/domain/entities/movies.dart';
import 'package:cinema_club/features/getmovies/domain/repositories/movie_repository.dart';

import 'package:cinema_club/features/getmovies/domain/usecases/get_moives.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late GetMoives usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(
    () {
      mockMovieRepository = MockMovieRepository();
      usecase = GetMoives(mockMovieRepository);
    },
  );
  const Movies tMovies = Movies(
    id: 84773,
    name: 'name',
    orginalName: 'orginal name',
    overView: 'overView',
    title: 'title',
    orginalTitle: 'oginal title',
    posterPath: 'path',
    backDropPath: 'backDropPath',
    mediaType: 'mediaType',
    orginalLanguage: 'orginalLanguage',
    releaseTime: '2024-06-11',
    voteAverage: 7.7,
    voteCount: 3548,
    genres: [
      16,
      10751,
      12,
    ],
  );
  const List<Movies> tMoviesList = [tMovies];
  test(
    'should get movies from the repository',
    () async {
      when(mockMovieRepository.getMovies())
          .thenAnswer((_) async => const Right(tMoviesList));
      final result = await usecase.getAllMovies();
      expect(result, const Right(tMoviesList));
      verify(mockMovieRepository.getMovies());
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}
