import 'package:equatable/equatable.dart';

class SettingEntity extends Equatable {
  final bool isDarkMode;
  final String languageCode;

  const SettingEntity({required this.isDarkMode, required this.languageCode});
  @override
  List<Object?> get props => [isDarkMode, languageCode];
}
