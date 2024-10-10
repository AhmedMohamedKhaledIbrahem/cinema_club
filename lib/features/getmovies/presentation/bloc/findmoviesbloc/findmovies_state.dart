part of 'findmovies_bloc.dart';

sealed class FindmoviesState extends Equatable {
  const FindmoviesState();

  @override
  List<Object> get props => [];
}

final class FindmoviesInitial extends FindmoviesState {}

final class FindmoviesLoading extends FindmoviesState {}

final class MovieFound extends FindmoviesState {
  final Movies moives;
  const MovieFound({required this.moives});
  @override
  List<Object> get props => [moives];
}

final class MovieError extends FindmoviesState {}
