part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  /*
  final List<Movies> movies;

  const MoviesLoaded({required this.movies});
  @override
  List<Object> get props => [movies];*/
  final List<Movies> allMovies;
  final List<Movies> popularMovies;
  final List<Movies> topRatedMovies;
  final List<Movies> upcomingMovies;

  const MoviesLoaded({
    this.allMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
  });

  @override
  List<Object> get props =>
      [allMovies, popularMovies, topRatedMovies, upcomingMovies];
}

final class MoviesError extends MoviesState {
  final String message;
  const MoviesError({required this.message});
  @override
  List<Object> get props => [message];
}
