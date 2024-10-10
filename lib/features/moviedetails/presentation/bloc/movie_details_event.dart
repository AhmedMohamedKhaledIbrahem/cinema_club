part of 'movie_details_bloc.dart';

sealed class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailsByIdEvent extends MovieDetailsEvent {
  final int id;
  const MovieDetailsByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}
