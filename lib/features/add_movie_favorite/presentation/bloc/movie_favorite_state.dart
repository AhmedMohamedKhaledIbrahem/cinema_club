part of 'movie_favorite_bloc.dart';

sealed class MovieFavoriteState extends Equatable {
  const MovieFavoriteState();

  @override
  List<Object> get props => [];
}

final class MovieFavoriteInitial extends MovieFavoriteState {}

final class MovieFavoriteLoading extends MovieFavoriteState {}

final class MovieFavoriteAdded extends MovieFavoriteState {}

final class MovieRemoteFavoriteAdded extends MovieFavoriteState {}

final class MovieFavoirteLoaded extends MovieFavoriteState {
  final List<MovieFavoriteModel> moviesFavorite;
  const MovieFavoirteLoaded({required this.moviesFavorite});
  @override
  List<Object> get props => [moviesFavorite];
}

final class MovieFavoirteDelete extends MovieFavoriteState {}

final class MovieRemoteFavoirteDelete extends MovieFavoriteState {}

final class MovieFavoirteError extends MovieFavoriteState {
  final String message;
  const MovieFavoirteError({required this.message});
  @override
  List<Object> get props => [message];
}

class DeleteAllFavoriteMovies extends MovieFavoriteState {}
