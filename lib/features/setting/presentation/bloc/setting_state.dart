part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

final class SettingLoading extends SettingState {}

final class SettingSaved extends SettingState {}

final class SettingLoaded extends SettingState {
  final SettingEntity settingEntity;
  const SettingLoaded({required this.settingEntity});
  @override
  List<Object> get props => [settingEntity];
}

class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});

  @override
  List<Object> get props => [message];
}
