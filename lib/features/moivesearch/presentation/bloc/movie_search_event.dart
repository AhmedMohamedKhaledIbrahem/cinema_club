part of 'movie_search_bloc.dart';

sealed class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchAndGenreEvent extends MovieSearchEvent {
  final List<GenresEntities> genres;
  final String query;
  const MovieSearchAndGenreEvent({required this.query, required this.genres});

  @override
  List<Object> get props => [query, genres];
}
