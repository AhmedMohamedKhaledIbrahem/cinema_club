import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:cinema_club/features/moviedetails/domain/repositories/movie_details_repository.dart';
import 'package:cinema_club/features/moviedetails/domain/usecases/movie_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_details_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieDetailsRepository>()])
void main() {
  late MockMovieDetailsRepository mockMovieDetailsRepository;
  late MovieDetailsUsecase searchMoiveUsecase;

  setUp(
    () {
      mockMovieDetailsRepository = MockMovieDetailsRepository();
      searchMoiveUsecase =
          MovieDetailsUsecase(repository: mockMovieDetailsRepository);
    },
  );
  const int tId = 1;
  const MovieDetailsEntity tMovieDetailsEntity = MovieDetailsEntity(
    id: 1,
    title: 'title',
    overView: 'overView',
    tagLine: 'tagLine',
    relaeaseDate: 'relaeaseDate',
    voteAverage: 3.6,
    voteCount: 345,
    geners: [
      GenresEntities(id: 1, name: 'name'),
      GenresEntities(id: 2, name: 'name2'),
    ],
    posterPath: 'posterPath',
    orginalTitle: 'orginaltitle',
  );
  test('should get moive by id from the repository ', () async {
    when(mockMovieDetailsRepository.movieDetailsById(any))
        .thenAnswer((_) async => const Right(tMovieDetailsEntity));
    final result = await searchMoiveUsecase.movieDetailsById(tId);
    expect(result, const Right(tMovieDetailsEntity));
    verify(mockMovieDetailsRepository.movieDetailsById(tId));
    verifyNoMoreInteractions(mockMovieDetailsRepository);
  });
}
