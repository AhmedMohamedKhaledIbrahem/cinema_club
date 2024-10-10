part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SaveSettingEvent extends SettingEvent {
  final SettingEntity settingEntity;
  const SaveSettingEvent({required this.settingEntity});
  @override
  List<Object> get props => [settingEntity];
}

class GetSettingEvent extends SettingEvent {}
