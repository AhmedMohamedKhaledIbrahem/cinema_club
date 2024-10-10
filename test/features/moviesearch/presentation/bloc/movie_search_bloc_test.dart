import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import 'package:cinema_club/features/moivesearch/domain/entities/movie_search_Entity.dart';
import 'package:cinema_club/features/moivesearch/domain/usecases/movie_search_usecase.dart';
import 'package:cinema_club/features/moivesearch/presentation/bloc/movie_search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieSearchUsecase>()])
void main() {
  late MockMovieSearchUsecase mockMovieSearchUsecase;
  late MovieSearchBloc bloc;
  setUp(() {
    mockMovieSearchUsecase = MockMovieSearchUsecase();
    bloc = MovieSearchBloc(movie: mockMovieSearchUsecase);
  });
  const tMovieSearchModel = [
    MovieSearchEntity(
      id: 238,
      orginalTitle: "The Godfather",
      title: "The Godfather",
      posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      overView:
          "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
      relaeaseDate: "1972-03-14",
      voteAverage: 8.69,
      voteCount: 20375,
      generId: [18, 80],
      genresName: ["Drama", "Crime"],
    )
  ];
  const tGenres = [
    GenresEntities(id: 18, name: "Drama"),
    GenresEntities(id: 80, name: "Crime"),
  ];
  const tQuery = "The Godfather";

  test('initial state should be empty', () async {
    expect(bloc.state, equals(MovieSearchInitial()));
  });

  group('MovieSearch', () {
    test('should return the data from the use case', () async {
      when(mockMovieSearchUsecase.movieSearch(any, any))
          .thenAnswer((_) async => const Right(tMovieSearchModel));
      bloc.add(const MovieSearchAndGenreEvent(query: tQuery, genres: tGenres));
      await untilCalled(mockMovieSearchUsecase.movieSearch(any, any));
      verify(mockMovieSearchUsecase.movieSearch(any, any));
    });

    test('should emits [Loading , Loaded] when the data is gotten successfully',
        () async {
      when(mockMovieSearchUsecase.movieSearch(any, any))
          .thenAnswer((_) async => const Right(tMovieSearchModel));
      expect(bloc.state, equals(MovieSearchInitial()));
      final expected = [
        MovieSearchLoading(),
        const MovieSearchLoaded(movieSearch: tMovieSearchModel)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const MovieSearchAndGenreEvent(query: tQuery, genres: tGenres));
    });

    test('should emits [Loading , Error] when the data is getting fails',
        () async {
      when(mockMovieSearchUsecase.movieSearch(any, any))
          .thenAnswer((_) async => Left(ServerFaliure()));
      expect(bloc.state, equals(MovieSearchInitial()));
      final expected = [
        MovieSearchLoading(),
        const MovieSearchError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const MovieSearchAndGenreEvent(query: tQuery, genres: tGenres));
    });
    test('''should emit [Loading , Error] with proper message for the error
        when getting data fails''', () async {
      when(mockMovieSearchUsecase.movieSearch(any, any))
          .thenAnswer((_) async => Left(ConnectionFaliure()));
      expect(bloc.state, equals(MovieSearchInitial()));
      final expected = [
        MovieSearchLoading(),
        const MovieSearchError(message: CONNECTION_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const MovieSearchAndGenreEvent(query: tQuery, genres: tGenres));
    });
  });
}
