import 'package:bloc/bloc.dart';
import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../domain/entities/movie_details_Entity.dart';
import '../../domain/usecases/movie_details_usecase.dart';

import 'package:equatable/equatable.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CONNECTION_FAILURE_MESSAGE = 'Connection Failure';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsUsecase movieDetails;

  MovieDetailsBloc({required this.movieDetails})
      : super(
          MovieDetailsInitial(),
        ) {
    on<MovieDetailsByIdEvent>(_onMovieDetailsByIdEvent);
  }

  _onMovieDetailsByIdEvent(
      MovieDetailsByIdEvent event, Emitter<MovieDetailsState> emit) async {
    emit(MovieDetailsLoading());
    final eitherMovie = await movieDetails.movieDetailsById(event.id);
    eitherMovie.fold(
      (failure) {
        emit(
          MovieDetailsError(message: _mapFailureToMessage(failure)),
        );
      },
      (movie) {
        emit(
          MovieDetailsLoaded(movie: movie),
        );
      },
    );
  }

  String _mapFailureToMessage(Failures failure) {
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
