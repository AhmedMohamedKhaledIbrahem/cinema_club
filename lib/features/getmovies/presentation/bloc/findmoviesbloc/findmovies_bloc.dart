import 'package:bloc/bloc.dart';
import '../../../domain/entities/movies.dart';
import '../../../domain/usecases/find_movie_by_id.dart';
import 'package:equatable/equatable.dart';

part 'findmovies_event.dart';
part 'findmovies_state.dart';

class FindmoviesBloc extends Bloc<FindmoviesEvent, FindmoviesState> {
  final FindMovieById findMovieById;
  FindmoviesBloc({required this.findMovieById}) : super(FindmoviesInitial()) {
    on<FindMovieByIdEvent>(_onFindMovieByIdEvent);
  }

  _onFindMovieByIdEvent(
      FindMovieByIdEvent event, Emitter<FindmoviesState> emit) async {
    final eitherMovie = await findMovieById.findMovieById(event.moiveId);
    eitherMovie.fold(
      (failure) => emit(MovieError()),
      (movies) => (emit(MovieFound(moives: movies))),
    );
  }
}
