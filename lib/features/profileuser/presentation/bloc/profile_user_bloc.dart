import 'package:bloc/bloc.dart';
import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:cinema_club/features/profileuser/domain/usecases/get_profile_user.dart';
import 'package:cinema_club/features/profileuser/domain/usecases/upload_profile_user_photo.dart';
import 'package:equatable/equatable.dart';

part 'profile_user_event.dart';
part 'profile_user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CONNECTION_FAILURE_MESSAGE = 'Connection Failure';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final GetProfileUser getProfileUser;
  final UploadProfileUserPhoto uploadProfileUserPhoto;
  ProfileUserBloc({
    required this.getProfileUser,
    required this.uploadProfileUserPhoto,
  }) : super(ProfileUserInitial()) {
    on<GetProfileUserEvent>((_onGetProfileUserEvent));
    on<UploadProfileUserPhotoEvent>((_onUploadProfileUserPhotoEvent));
  }

  _onGetProfileUserEvent(
      GetProfileUserEvent event, Emitter<ProfileUserState> emit) async {
    emit(ProfileUserLoading());
    final eitherGetProfileUser = await getProfileUser.getProfileUser();
    eitherGetProfileUser.fold(
      (failure) =>
          emit(ProfileUserError(message: _mapFailureToMessage(failure))),
      (profileUser) => emit(ProfileUserLoaded(profileUserEntitiy: profileUser)),
    );
  }

  _onUploadProfileUserPhotoEvent(
    UploadProfileUserPhotoEvent event,
    Emitter<ProfileUserState> emit,
  ) async {
    emit(ProfileUserLoading());
    final eitherUploadProfileUserPhoto =
        await uploadProfileUserPhoto.uploadProfileUserPhoto(event.pathPhoto);
    eitherUploadProfileUserPhoto.fold(
      (failure) => emit(UploadedProfileUserPhotoError(
          message: _mapFailureToMessage(failure))),
      (_) => emit(UploadedProfileUserPhoto()),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case const (ServerFaliure):
        return SERVER_FAILURE_MESSAGE;
      case const (ConnectionFaliure):
        return CONNECTION_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
