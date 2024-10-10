import 'package:cinema_club/features/geners/data/models/genres_model.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/geners/domain/repositories/genre_repository.dart';

import 'package:cinema_club/features/geners/domain/usecases/get_genre.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_genre_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GenreRepository>()])
void main() {
  late GetGenreUseCase getGenereUseCase;
  late MockGenreRepository mockGenreRepository;

  setUp(
    () {
      mockGenreRepository = MockGenreRepository();
      getGenereUseCase = GetGenreUseCase(repository: mockGenreRepository);
    },
  );
  group(
    'should get genere from the repository',
    () {
      const GenresModel tgenresModel = GenresModel(id: 1, name: 'name');
      const List<GenresEntities> tGenresEntity = [tgenresModel];

      test(
        'should get list of genere from the repository',
        () async {
          when(mockGenreRepository.getGeneres())
              .thenAnswer((_) async => const Right(tGenresEntity));
          final result = await getGenereUseCase.getGeneres();
          expect(result, const Right(tGenresEntity));
          verify(getGenereUseCase.getGeneres());
          verifyNoMoreInteractions(mockGenreRepository);
        },
      );
    },
  );
}
