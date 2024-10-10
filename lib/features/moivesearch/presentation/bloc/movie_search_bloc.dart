import 'package:bloc/bloc.dart';
import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../../geners/domain/entities/genresEntities.dart';
import '../../../getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import '../../domain/entities/movie_search_Entity.dart';
import '../../domain/usecases/movie_search_usecase.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieSearchUsecase movie;
  MovieSearchBloc({required this.movie}) : super(MovieSearchInitial()) {
    on<MovieSearchAndGenreEvent>(_onMoviesSearchEvent);
  }

  _onMoviesSearchEvent(
      MovieSearchAndGenreEvent event, Emitter<MovieSearchState> emit) async {
    // emit(MovieSearchLoading());
    final eitherMovieSearch =
        await movie.movieSearch(event.query, event.genres);

    eitherMovieSearch.fold(
      (failure) =>
          emit(MovieSearchError(message: _mapFailureToMessage(failure))),
      (movie) => emit(MovieSearchLoaded(movieSearch: movie)),
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
