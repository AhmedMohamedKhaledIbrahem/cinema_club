part of 'movie_search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}

final class MovieSearchLoading extends MovieSearchState {}

final class MovieSearchLoaded extends MovieSearchState {
  final List<MovieSearchEntity> movieSearch;
  const MovieSearchLoaded({required this.movieSearch});
  @override
  List<Object> get props => [movieSearch];
}

final class MovieSearchError extends MovieSearchState {
  final String message;
  const MovieSearchError({required this.message});
  @override
  List<Object> get props => [message];
}
