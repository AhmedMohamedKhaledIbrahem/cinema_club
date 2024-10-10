part of 'findmovies_bloc.dart';

sealed class FindmoviesEvent extends Equatable {
  const FindmoviesEvent();

  @override
  List<Object> get props => [];
}

class FindMovieByIdEvent extends FindmoviesEvent {
  final int moiveId;
  const FindMovieByIdEvent({
    required this.moiveId,
  });
}
