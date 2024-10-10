import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:cinema_club/features/moviedetails/domain/usecases/movie_details_usecase.dart';
import 'package:cinema_club/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_details_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieDetailsUsecase>()])
void main() {
  late MockMovieDetailsUsecase mockMovieDetails;
  late MovieDetailsBloc bloc;

  setUp(
    () {
      mockMovieDetails = MockMovieDetailsUsecase();
      bloc = MovieDetailsBloc(movieDetails: mockMovieDetails);
    },
  );
  test('initialState should be empty', () {
    expect(bloc.state, equals(MovieDetailsInitial()));
  });
  group(
    'searchMoviebyId',
    () {
      const tMovieDetailsEntity = MovieDetailsEntity(
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
      const tId = 1;

      test('should get the data from the MovieDetailsEntity', () async {
        when(mockMovieDetails.movieDetailsById(tId))
            .thenAnswer((_) async => const Right(tMovieDetailsEntity));
        bloc.add(const MovieDetailsByIdEvent(id: tId));
        await untilCalled(mockMovieDetails.movieDetailsById(tId));
        verify(mockMovieDetails.movieDetailsById(tId));
      });
      test('should emit [Loading and Loaded] when is data gotten successful',
          () async {
        when(mockMovieDetails.movieDetailsById(tId))
            .thenAnswer((_) async => const Right(tMovieDetailsEntity));
        expect(bloc.state, equals(MovieDetailsInitial()));
        final expected = [
          MovieDetailsLoading(),
          const MovieDetailsLoaded(movie: tMovieDetailsEntity),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(const MovieDetailsByIdEvent(id: tId));
      });

      test('should emit [Loading and Error] when is data getting fails',
          () async {
        when(mockMovieDetails.movieDetailsById(tId))
            .thenAnswer((_) async => Left(ServerFaliure()));
        expect(bloc.state, equals(MovieDetailsInitial()));
        final expected = [
          MovieDetailsLoading(),
          const MovieDetailsError(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(const MovieDetailsByIdEvent(id: tId));
      });
      test(
        '''should emit [Loading , Error] with proper message for the error
           when getting data fails''',
        () {
          when(mockMovieDetails.movieDetailsById(tId))
              .thenAnswer((_) async => Left(ConnectionFaliure()));
          expect(bloc.state, equals(MovieDetailsInitial()));
          final expected = [
            MovieDetailsLoading(),
            const MovieDetailsError(message: CONNECTION_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          bloc.add(const MovieDetailsByIdEvent(id: tId));
        },
      );
    },
  );
}
