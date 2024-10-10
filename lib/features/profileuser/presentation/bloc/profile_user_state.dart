part of 'profile_user_bloc.dart';

sealed class ProfileUserState extends Equatable {
  const ProfileUserState();

  @override
  List<Object> get props => [];
}

final class ProfileUserInitial extends ProfileUserState {}

final class ProfileUserLoading extends ProfileUserState {}

final class ProfileUserLoaded extends ProfileUserState {
  final ProfileUserEntitiy profileUserEntitiy;
  const ProfileUserLoaded({required this.profileUserEntitiy});
  @override
  List<Object> get props => [profileUserEntitiy];
}

final class ProfileUserError extends ProfileUserState {
  final String message;
  const ProfileUserError({required this.message});
  @override
  List<Object> get props => [message];
}

final class UploadedProfileUserPhoto extends ProfileUserState {}

final class UploadedProfileUserPhotoError extends ProfileUserState {
  final String message;
  const UploadedProfileUserPhotoError({required this.message});
  @override
  List<Object> get props => [message];
}
