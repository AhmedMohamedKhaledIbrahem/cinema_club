import 'package:bloc/bloc.dart';
import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_movie_to_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_remote_movie_to_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_all.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_movie_from_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_remote_movie_to_favoirte.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_favorite_movies.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_remote_favorite_movies.dart';
import 'package:cinema_club/features/moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:equatable/equatable.dart';

part 'movie_favorite_event.dart';
part 'movie_favorite_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MovieFavoriteBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {
  final AddMovieToFavorite addMovieToFavorite;
  final DeleteMovieFromFavorite deleteMovieFromFavorite;
  final GetFavoriteMovies getFavoriteMovies;
  final AddRemoteMovieToFavorite addAemoteMovieToFavorite;
  final DeleteRemoteMovieToFavoirte deleteRemoteMovieToFavoirte;
  final GetRemoteFavoriteMovies getRemoteFavoriteMovies;
  final DeleteAll deleteAll;

  MovieFavoriteBloc({
    required this.addMovieToFavorite,
    required this.deleteMovieFromFavorite,
    required this.getFavoriteMovies,
    required this.addAemoteMovieToFavorite,
    required this.deleteRemoteMovieToFavoirte,
    required this.getRemoteFavoriteMovies,
    required this.deleteAll,
  }) : super(MovieFavoriteInitial()) {
    on<AddMovieToFavoriteEvent>(_onAddMovieFavorite);
    on<DeleteMovieFromFavoriteEvent>(_onDeleteMovieFromFavorite);
    on<AddRemoteMovieToFavoriteEvent>(_onAddRemoteMovieToFavoriteEvent);
    on<DeleteRemoteMovieFromFavoriteEvent>(
        _onDeleteRemoteMovieFromFavoriteEvent);
    on<GetFavoriteMoviesEvent>(_onGetFavoriteMovies);
    on<GetRemoteFavoriteMoviesEvent>(_onGetRemoteFavoriteMovies);
    on<DeleteAllFavoriteMoviesEvent>(_onDeleteAllFavoriteMoviesEvent);
  }

  _onDeleteAllFavoriteMoviesEvent(DeleteAllFavoriteMoviesEvent event,
      Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherDelteMovie = await deleteAll.deleteAll();
    eitherDelteMovie.fold(
      (faliure) =>
          emit(MovieFavoirteError(message: _mapFailureToMessage(faliure))),
      (_) => emit(DeleteAllFavoriteMovies()),
    );
  }

  _onAddMovieFavorite(
      AddMovieToFavoriteEvent event, Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherAddMoive = await addMovieToFavorite.addMovieToFavorite(
      event.movieDetailsEntity,
    );
    eitherAddMoive.fold(
      (faliure) =>
          emit(MovieFavoirteError(message: _mapFailureToMessage(faliure))),
      (_) => emit(MovieFavoriteAdded()),
    );
  }

  _onDeleteMovieFromFavorite(DeleteMovieFromFavoriteEvent event,
      Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherDelteMovie =
        await deleteMovieFromFavorite.deleteMovieFromFavorite(
      event.movieId,
    );
    eitherDelteMovie.fold(
      (faliure) =>
          emit(MovieFavoirteError(message: _mapFailureToMessage(faliure))),
      (_) => emit(MovieFavoirteDelete()),
    );
  }

  _onAddRemoteMovieToFavoriteEvent(AddRemoteMovieToFavoriteEvent event,
      Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherAddMoive =
        await addAemoteMovieToFavorite.addRemoteMovieToFavorite(
      event.movieDetailsEntity,
    );
    eitherAddMoive.fold(
      (faliure) =>
          emit(MovieFavoirteError(message: _mapFailureToMessage(faliure))),
      (_) => emit(MovieFavoriteAdded()),
    );
  }

  _onDeleteRemoteMovieFromFavoriteEvent(
      DeleteRemoteMovieFromFavoriteEvent event,
      Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherDelteMovie =
        await deleteRemoteMovieToFavoirte.deleteRemoteMovieFromFavorite(
      event.movieId,
    );
    eitherDelteMovie.fold(
      (faliure) =>
          emit(MovieFavoirteError(message: _mapFailureToMessage(faliure))),
      (_) => emit(MovieFavoirteDelete()),
    );
  }

  _onGetFavoriteMovies(
      GetFavoriteMoviesEvent event, Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherGetFavoriteMovies = await getFavoriteMovies.getFavoriteMovies();
    eitherGetFavoriteMovies.fold(
      (faliure) => emit(
        MovieFavoirteError(message: _mapFailureToMessage(faliure)),
      ),
      (favoriteMovies) => emit(
        MovieFavoirteLoaded(moviesFavorite: favoriteMovies),
      ),
    );
  }

  _onGetRemoteFavoriteMovies(GetRemoteFavoriteMoviesEvent event,
      Emitter<MovieFavoriteState> emit) async {
    emit(MovieFavoriteLoading());
    final eitherGetFavoriteMovies =
        await getRemoteFavoriteMovies.getRemoteFavoriteMovies();
    eitherGetFavoriteMovies.fold(
      (faliure) => emit(
        MovieFavoirteError(message: _mapFailureToMessage(faliure)),
      ),
      (favoriteMovies) => emit(
        MovieFavoirteLoaded(moviesFavorite: favoriteMovies),
      ),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    if (failure is ServerFaliure) {
      return failure.message;
    } else if (failure is CacheFaliure) {
      return failure.message;
    } else {
      return 'Unexpected Error';
    }
  }
}
