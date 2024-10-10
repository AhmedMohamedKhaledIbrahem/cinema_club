import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_movie_to_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_remote_movie_to_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_all.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_movie_from_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_remote_movie_to_favoirte.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_favorite_movies.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_remote_favorite_movies.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/features/geners/domain/entities/genresEntities.dart';
import 'package:cinema_club/features/moviedetails/data/models/movie_details_model.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_favorite_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetFavoriteMovies>(),
  MockSpec<DeleteMovieFromFavorite>(),
  MockSpec<AddMovieToFavorite>(),
  MockSpec<AddRemoteMovieToFavorite>(),
  MockSpec<GetRemoteFavoriteMovies>(),
  MockSpec<DeleteRemoteMovieToFavoirte>(),
  MockSpec<DeleteAll>(),
])
void main() {
  late MovieFavoriteBloc movieFavoriteBloc;
  late MockAddMovieToFavorite mockAddMovieToFavorite;
  late MockDeleteMovieFromFavorite mockDeleteMovieFromFavorite;
  late MockGetFavoriteMovies mockGetFavoriteMovies;
  late MockAddRemoteMovieToFavorite mockAddRemoteMovieToFavorite;
  late MockGetRemoteFavoriteMovies mockGetRemoteFavoriteMovies;
  late MockDeleteRemoteMovieToFavoirte mockDeleteRemoteMovieToFavoirte;
  late MockDeleteAll mockDeleteAll;

  setUp(() {
    mockAddMovieToFavorite = MockAddMovieToFavorite();
    mockDeleteMovieFromFavorite = MockDeleteMovieFromFavorite();
    mockGetFavoriteMovies = MockGetFavoriteMovies();
    mockAddRemoteMovieToFavorite = MockAddRemoteMovieToFavorite();
    mockGetRemoteFavoriteMovies = MockGetRemoteFavoriteMovies();
    mockDeleteRemoteMovieToFavoirte = MockDeleteRemoteMovieToFavoirte();
    mockDeleteAll = MockDeleteAll();
    movieFavoriteBloc = MovieFavoriteBloc(
        addMovieToFavorite: mockAddMovieToFavorite,
        deleteMovieFromFavorite: mockDeleteMovieFromFavorite,
        getFavoriteMovies: mockGetFavoriteMovies,
        addAemoteMovieToFavorite: mockAddRemoteMovieToFavorite,
        deleteRemoteMovieToFavoirte: mockDeleteRemoteMovieToFavoirte,
        getRemoteFavoriteMovies: mockGetRemoteFavoriteMovies,
        deleteAll: mockDeleteAll);
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

  const tMovieDetialsModel = MovieDetailsModel(
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
  final tMovieFavoirtModel = MovieFavoriteModel.fromDomain(tMovieDetialsModel);

  const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
  group('AddMovieToFavoriteEvent', () {
    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteAdded]
       when AddMovieToFavoriteEvent is added''',
      build: () {
        when(mockAddMovieToFavorite.addMovieToFavorite(any))
            .thenAnswer((_) async => const Right(null));
        return movieFavoriteBloc;
      },
      act: (bloc) => bloc.add(const AddMovieToFavoriteEvent(
          movieDetailsEntity: tMovieDetialsEntity)),
      expect: () => [MovieFavoriteLoading(), MovieFavoriteAdded()],
    );

    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteError]
       when AddMovieToFavoriteEvent is fails''',
      build: () {
        when(mockAddMovieToFavorite.addMovieToFavorite(any)).thenAnswer(
            (_) async => const Left(CacheFaliure(CACHE_FAILURE_MESSAGE)));
        return movieFavoriteBloc;
      },
      act: (bloc) => bloc.add(const AddMovieToFavoriteEvent(
          movieDetailsEntity: tMovieDetialsEntity)),
      expect: () => [
        MovieFavoriteLoading(),
        const MovieFavoirteError(message: CACHE_FAILURE_MESSAGE)
      ],
    );
  });

  group('DeleteMovieFromFavoriteEvent', () {
    const tmovieId = 1;
    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteDelete]
       when DeleteMovieFromFavoriteEvent is Deleted''',
      build: () {
        when(mockDeleteMovieFromFavorite.deleteMovieFromFavorite(any))
            .thenAnswer((_) async => const Right(null));
        return movieFavoriteBloc;
      },
      act: (bloc) =>
          bloc.add(const DeleteMovieFromFavoriteEvent(movieId: tmovieId)),
      expect: () => [MovieFavoriteLoading(), MovieFavoirteDelete()],
    );

    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteError]
       when DeleteMovieFromFavoriteEvent is fails''',
      build: () {
        when(mockDeleteMovieFromFavorite.deleteMovieFromFavorite(any))
            .thenAnswer(
                (_) async => const Left(CacheFaliure(CACHE_FAILURE_MESSAGE)));
        return movieFavoriteBloc;
      },
      act: (bloc) =>
          bloc.add(const DeleteMovieFromFavoriteEvent(movieId: tmovieId)),
      expect: () => [
        MovieFavoriteLoading(),
        const MovieFavoirteError(message: CACHE_FAILURE_MESSAGE)
      ],
    );
  });

  group('DeleteMovieFromFavoriteEvent', () {
    final List<MovieFavoriteModel> tMoiesFavorite = [tMovieFavoirtModel];

    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteLoaded]
       when GetFavoriteMoviesEvent is geted''',
      build: () {
        when(mockGetFavoriteMovies.getFavoriteMovies())
            .thenAnswer((_) async => Right(tMoiesFavorite));
        return movieFavoriteBloc;
      },
      act: (bloc) => bloc.add(GetFavoriteMoviesEvent()),
      expect: () => [
        MovieFavoriteLoading(),
        MovieFavoirteLoaded(moviesFavorite: tMoiesFavorite)
      ],
    );

    blocTest<MovieFavoriteBloc, MovieFavoriteState>(
      '''emits [MovieFavoriteLoading, MovieFavoriteError]
       when GetFavoriteMoviesEvent is fails''',
      build: () {
        when(mockGetFavoriteMovies.getFavoriteMovies()).thenAnswer(
            (_) async => const Left(CacheFaliure(CACHE_FAILURE_MESSAGE)));
        return movieFavoriteBloc;
      },
      act: (bloc) => bloc.add(GetFavoriteMoviesEvent()),
      expect: () => [
        MovieFavoriteLoading(),
        const MovieFavoirteError(message: CACHE_FAILURE_MESSAGE)
      ],
    );
  });
}
