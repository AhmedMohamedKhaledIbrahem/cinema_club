import 'package:bloc/bloc.dart';
import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/usecases/get_setting.dart';
import 'package:cinema_club/features/setting/domain/usecases/save_setting.dart';
import 'package:equatable/equatable.dart';

part 'setting_event.dart';
part 'setting_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetSetting getSetting;
  final SaveSetting saveSetting;
  SettingBloc({required this.getSetting, required this.saveSetting})
      : super(SettingInitial()) {
    on<GetSettingEvent>(_onGetSettingEvent);
    on<SaveSettingEvent>(_onSaveSettingEvent);
  }
  _onGetSettingEvent(GetSettingEvent event, Emitter<SettingState> emit) async {
    // emit(SettingLoading());
    final eitherGet = await getSetting.getSetting();
    eitherGet.fold(
      (failure) => emit(SettingError(message: _mapFailureToMessage(failure))),
      (setting) => emit(SettingLoaded(settingEntity: setting)),
    );
  }

  _onSaveSettingEvent(
      SaveSettingEvent event, Emitter<SettingState> emit) async {
    // emit(SettingLoading());
    try {
      final eitherSave = await saveSetting.saveSetting(event.settingEntity);
      await eitherSave.fold(
        (failure) async {
          emit(SettingError(message: _mapFailureToMessage(failure)));
        },
        (_) async {
          emit(SettingSaved());
          // After saving, fetch the settings again
          final eitherGet = await getSetting.getSetting();
          eitherGet.fold(
            (failure) =>
                emit(SettingError(message: _mapFailureToMessage(failure))),
            (setting) => emit(SettingLoaded(settingEntity: setting)),
          );
        },
      );
    } catch (e) {
      emit(SettingError(message: 'An unexpected error occurred: $e'));
    }
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case const (ServerFaliure):
        return SERVER_FAILURE_MESSAGE;
      case const (CacheFaliure):
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
