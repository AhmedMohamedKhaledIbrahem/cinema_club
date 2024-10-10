import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/getmovies/domain/entities/movies.dart';
import 'package:cinema_club/features/getmovies/domain/usecases/find_movie_by_id.dart';
import 'package:cinema_club/features/getmovies/domain/usecases/get_moives.dart';
import 'package:cinema_club/features/getmovies/domain/usecases/get_popular_movies.dart';
import 'package:cinema_club/features/getmovies/domain/usecases/get_top_rated_movies.dart';
import 'package:cinema_club/features/getmovies/domain/usecases/get_upcoming_movies.dart';
import 'package:cinema_club/features/getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_block_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetMoives>(),
  MockSpec<GetTopRatedMovies>(),
  MockSpec<GetPopularMovies>(),
  MockSpec<GetUpcomingMovies>(),
  MockSpec<FindMovieById>()
])
void main() {
  late MoviesBloc bloc;
  late MockGetMoives mockGetMoives;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetUpcomingMovies mockGetUpcomingMovies;

  setUp(() {
    mockGetMoives = MockGetMoives();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetUpcomingMovies = MockGetUpcomingMovies();
    bloc = MoviesBloc(
      getMoives: mockGetMoives,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
      getUpcomingMovies: mockGetUpcomingMovies,
    );
  });

  test('initialState should be Empty', () {
    expect(bloc.state, equals(MoviesInitial()));
  });

  group('GetMovies', () {
    const tMovies = [
      Movies(
        id: 120,
        name: "name",
        orginalName: "orginalName",
        overView: "overView",
        title: "",
        orginalTitle: "",
        posterPath: "posterPath",
        backDropPath: "backDropPath",
        mediaType: "mediaType",
        orginalLanguage: "orginalLanguage",
        releaseTime: "",
        voteAverage: 7.3,
        voteCount: 234,
        genres: [13, 20],
      )
    ];
    test('should get data  from the movies use case', () async {
      when(mockGetMoives.getAllMovies())
          .thenAnswer((_) async => const Right(tMovies));
      bloc.add(GetMoviesEvent());
      await untilCalled(mockGetMoives.getAllMovies());
      verify(mockGetMoives.getAllMovies());
    });

    test('should emit [Loading , Loaded] when data is gotten successfully',
        () async {
      when(mockGetMoives.getAllMovies())
          .thenAnswer((_) async => const Right(tMovies));
      expect(bloc.state, equals(MoviesInitial()));
      final expected = [
        MoviesLoading(),
        const MoviesLoaded(allMovies: tMovies),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(GetMoviesEvent());
    });

    test('should emit [Loading, Error] when data is getting fails', () async {
      when(mockGetMoives.getAllMovies())
          .thenAnswer((_) async => Left(ServerFaliure()));
      expect(bloc.state, equals(MoviesInitial()));
      final expected = [
        MoviesLoading(),
        const MoviesError(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(GetMoviesEvent());
    });
  });
  test('''should emit [Loading , Error] with proper message for the error
    when getting data fails''', () async {
    when(mockGetMoives.getAllMovies())
        .thenAnswer((_) async => Left(ConnectionFaliure()));
    expect(bloc.state, equals(MoviesInitial()));
    final expected = [
      MoviesLoading(),
      const MoviesError(message: CONNECTION_FAILURE_MESSAGE),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));
    bloc.add(GetMoviesEvent());
  });
}
