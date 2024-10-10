part of 'genre_bloc.dart';

sealed class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

final class GenreInitial extends GenreState {}

final class GenreLoading extends GenreState {}

final class GenreLoaded extends GenreState {
  final List<GenresEntities> genres;
  const GenreLoaded({required this.genres});
  @override
  List<Object> get props => [genres];
}

final class GenreError extends GenreState {
  final String message;
  const GenreError({required this.message});
  @override
  List<Object> get props => [message];
}
