import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moivesearch/domain/entities/movie_search_Entity.dart';
import 'package:cinema_club/features/moivesearch/domain/repositories/movie_search_repository.dart';
import 'package:cinema_club/features/moivesearch/domain/usecases/movie_search_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieSearchRepository>()])
void main() {
  late MockMovieSearchRepository mockMovieSearchRepository;
  late MovieSearchUsecase usecase;

  setUp(() {
    mockMovieSearchRepository = MockMovieSearchRepository();
    usecase = MovieSearchUsecase(repository: mockMovieSearchRepository);
  });
  const tquery = "orginalTitle";
  const tGeneresEntity = <GenresEntities>[];
  List<MovieSearchEntity> tMoiveSearchEntity = [
    const MovieSearchEntity(
        id: 10,
        orginalTitle: "orginalTitle",
        title: "orginalTitle",
        posterPath: "posterPath",
        overView: "overView",
        relaeaseDate: "relaeaseDate",
        voteAverage: 1.0,
        voteCount: 1,
        generId: [1, 2, 3],
        genresName: ["Action", "Adventure"])
  ];
  test('should retrun list of Movies from the repository', () async {
    when(mockMovieSearchRepository.movieSearch(any, any))
        .thenAnswer((_) async => Right(tMoiveSearchEntity));
    final resutl = await usecase.movieSearch(tquery, tGeneresEntity);
    expect(resutl, Right(tMoiveSearchEntity));
    verify(mockMovieSearchRepository.movieSearch(tquery, tGeneresEntity));
    verifyNoMoreInteractions(mockMovieSearchRepository);
  });
}
