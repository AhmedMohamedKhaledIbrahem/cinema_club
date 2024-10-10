import 'package:bloc/bloc.dart';
import '../../../../core/errors/connection_faliure.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/server_faliure.dart';
import '../../domain/entities/genresEntities.dart';
import '../../domain/usecases/get_genre.dart';
import '../../../getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import 'package:equatable/equatable.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetGenreUseCase getGenre;

  GenreBloc({required this.getGenre}) : super(GenreInitial()) {
    on<GetGenresEvent>(_onGetGenresEvent);
  }

  _onGetGenresEvent(GetGenresEvent event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    final eitherGenre = await getGenre.getGeneres();
    eitherGenre.fold(
      (failure) => emit(GenreError(message: _mapFailureToMessage(failure))),
      (genre) => emit(GenreLoaded(genres: genre)),
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
