import 'dart:ui';

import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';

class SettingModel extends SettingEntity {
  const SettingModel({required super.isDarkMode, required super.languageCode});

  factory SettingModel.fromPreferences(Map<String, dynamic> preferences) {
    return SettingModel(
      isDarkMode: preferences['theme_mode'] as bool? ?? false,
      languageCode: preferences['language'] as String? ??
          PlatformDispatcher.instance.locale.languageCode,
    );
  }

  Map<String, dynamic> toPreferences() {
    return {
      'theme_mode': isDarkMode,
      'language': languageCode,
    };
  }
}
