import 'dart:ui';

import 'package:cinema_club/features/setting/data/datasources/setting_local_data_source.dart';
import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingLocalDataSourceImpl implements SettingLocalDataSource {
  final SharedPreferences sharedPreferences;
  SettingLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<SettingModel> getSetting() async {
    final languageDefultDevice =
        PlatformDispatcher.instance.locale.languageCode;
    final prefs = {
      'theme_mode': sharedPreferences.getBool('theme_mode') ?? false,
      'language':
          sharedPreferences.getString('language') ?? languageDefultDevice,
    };
    return SettingModel.fromPreferences(prefs);
  }

  @override
  Future<void> saveSetting(SettingModel settings) async {
    await sharedPreferences.setBool('theme_mode', settings.isDarkMode);
    await sharedPreferences.setString('language', settings.languageCode);
  }
}
