part of 'movie_favorite_bloc.dart';

sealed class MovieFavoriteEvent extends Equatable {
  const MovieFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddMovieToFavoriteEvent extends MovieFavoriteEvent {
  final MovieDetailsEntity movieDetailsEntity;
  const AddMovieToFavoriteEvent({required this.movieDetailsEntity});
  @override
  List<Object> get props => [movieDetailsEntity];
}

class DeleteMovieFromFavoriteEvent extends MovieFavoriteEvent {
  final int movieId;
  const DeleteMovieFromFavoriteEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}

class AddRemoteMovieToFavoriteEvent extends MovieFavoriteEvent {
  final MovieDetailsEntity movieDetailsEntity;
  const AddRemoteMovieToFavoriteEvent({required this.movieDetailsEntity});
  @override
  List<Object> get props => [movieDetailsEntity];
}

class DeleteRemoteMovieFromFavoriteEvent extends MovieFavoriteEvent {
  final int movieId;
  const DeleteRemoteMovieFromFavoriteEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}

class GetFavoriteMoviesEvent extends MovieFavoriteEvent {}

class GetRemoteFavoriteMoviesEvent extends MovieFavoriteEvent {}

class ToggleFavoriteMovieEvent extends MovieFavoriteEvent {
  final MovieDetailsEntity movie;
  const ToggleFavoriteMovieEvent({required this.movie});
  @override
  List<Object> get props => [movie];
}

class DeleteAllFavoriteMoviesEvent extends MovieFavoriteEvent {}
