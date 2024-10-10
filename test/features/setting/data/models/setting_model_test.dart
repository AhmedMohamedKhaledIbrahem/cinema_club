import 'dart:ui';

import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tsettingModel = SettingModel(isDarkMode: true, languageCode: 'en');

  group('SettingModel', () {
    final Map<String, dynamic> tPreferences = {
      'theme_mode': true,
      'language': 'en',
    };
    test('should be SettingModel subclass from SettingEntity', () async {
      expect(tsettingModel, isA<SettingEntity>());
    });
    test('fromPreferences should use default values if preferences are missing',
        () {
      final Map<String, dynamic> preferences = {};

      final settingModel = SettingModel.fromPreferences(preferences);
      expect(settingModel.isDarkMode, false);
      expect(settingModel.languageCode,
          PlatformDispatcher.instance.locale.languageCode);
    });
    test('fromPreferences should return correct value', () async {
      final settingModel = SettingModel.fromPreferences(tPreferences);
      expect(settingModel.isDarkMode, true);
      expect(settingModel.languageCode, 'en');
    });

    test('toPreferences should return a map with correct values', () {
      const settingModel = SettingModel(
        isDarkMode: true,
        languageCode: 'en',
      );

      final preferences = settingModel.toPreferences();

      expect(preferences['theme_mode'], true);
      expect(preferences['language'], 'en');
    });
  });
}
