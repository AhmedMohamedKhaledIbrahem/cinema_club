part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent extends Equatable {
  const ProfileUserEvent();

  @override
  List<Object> get props => [];
}

class GetProfileUserEvent extends ProfileUserEvent {
  @override
  List<Object> get props => [];
}

class UploadProfileUserPhotoEvent extends ProfileUserEvent {
  final String pathPhoto;
  const UploadProfileUserPhotoEvent({required this.pathPhoto});
  @override
  List<Object> get props => [pathPhoto];
}
