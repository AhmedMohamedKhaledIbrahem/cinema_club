import 'package:bloc/bloc.dart';
import '../../../../../core/errors/connection_faliure.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/server_faliure.dart';
import '../../../domain/entities/movies.dart';
import '../../../domain/usecases/get_moives.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';
import '../../../domain/usecases/get_upcoming_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'movies_event.dart';
part 'movies_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CONNECTION_FAILURE_MESSAGE = 'Connection Failure';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoives getMoives;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetUpcomingMovies getUpcomingMovies;

  MoviesBloc({
    required this.getMoives,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpcomingMovies,
  }) : super(MoviesInitial()) {
    on<GetMoviesEvent>(_onGetMoviesEvent);
    on<GetPopularMoviesEvent>(_onGetPopularMoviesEvent);
    on<GetTopRatedMoviesEvent>(_onGetTopRatedMoviesEvent);
    on<GetUpcomingMoviesEvent>(_onGetUpcomingMoviesEvent);
  }

  //! Handler for GetMoviesEvent
  Future<void> _onGetMoviesEvent(
      GetMoviesEvent event, Emitter<MoviesState> emit) async {
    await _getMovies(
      emit,
      getMovies: getMoives.getAllMovies,
      eventType: 'allMovies',
    );
  }

  //! Handler for GetPopularMoviesEvent
  Future<void> _onGetPopularMoviesEvent(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    await _getMovies(
      emit,
      getMovies: getPopularMovies.getPopularMovies,
      eventType: 'popularMovies',
    );
  }

  //! Handler for GetTopRatedMoviesEvent
  Future<void> _onGetTopRatedMoviesEvent(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    await _getMovies(
      emit,
      getMovies: getTopRatedMovies.getTopRatedMovies,
      eventType: 'topRatedMovies',
    );
  }

  //! Handler for GetUpcomingMoviesEvent
  Future<void> _onGetUpcomingMoviesEvent(
      GetUpcomingMoviesEvent event, Emitter<MoviesState> emit) async {
    await _getMovies(
      emit,
      getMovies: getUpcomingMovies.getUpcomingMovies,
      eventType: 'upcomingMovies',
    );
  }

  void _updateMoviesList(
    Emitter<MoviesState> emit,
    MoviesLoaded currentState,
    List<Movies> newMovies,
    String eventType,
  ) {
    final Map<String, List<Movies>> updatedMovies = {
      'allMovies': currentState.allMovies,
      'popularMovies': currentState.popularMovies,
      'topRatedMovies': currentState.topRatedMovies,
      'upcomingMovies': currentState.upcomingMovies,
    };

    updatedMovies[eventType] = updatedMovies[eventType]! + newMovies;

    emit(MoviesLoaded(
      allMovies: updatedMovies['allMovies']!,
      popularMovies: updatedMovies['popularMovies']!,
      topRatedMovies: updatedMovies['topRatedMovies']!,
      upcomingMovies: updatedMovies['upcomingMovies']!,
    ));
  }

  Future<void> _getMovies(
    Emitter<MoviesState> emit, {
    required Future<Either<Failures, List<Movies>>> Function() getMovies,
    required String eventType,
  }) async {
    final currentState = state;

    if (currentState is MoviesLoaded) {
      // Append new movies to the existing list based on eventType
      final failureOrMovies = await getMovies();
      failureOrMovies.fold(
        (failure) => emit(MoviesError(message: mapFailureToMessage(failure))),
        (newMovies) =>
            _updateMoviesList(emit, currentState, newMovies, eventType),
      );
    } else {
      // Initial load
      emit(MoviesLoading());
      final failureOrMovies = await getMovies();
      _eitherLoadedOrErrorState(emit, failureOrMovies, eventType);
    }
  }

  void _eitherLoadedOrErrorState(
    Emitter<MoviesState> emit,
    Either<Failures, List<Movies>> failureOrMovies,
    String eventType,
  ) {
    final currentState = state;

    failureOrMovies.fold(
      (failure) => emit(MoviesError(message: mapFailureToMessage(failure))),
      (newMovies) {
        if (currentState is MoviesLoaded) {
          _updateMoviesList(emit, currentState, newMovies, eventType);
        } else {
          emit(MoviesLoaded(
            allMovies: eventType == 'allMovies' ? newMovies : [],
            popularMovies: eventType == 'popularMovies' ? newMovies : [],
            topRatedMovies: eventType == 'topRatedMovies' ? newMovies : [],
            upcomingMovies: eventType == 'upcomingMovies' ? newMovies : [],
          ));
        }
      },
    );
  }

  String mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case const (ServerFaliure):
        return SERVER_FAILURE_MESSAGE;
      case const (ConnectionFaliure):
        return CONNECTION_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
