import 'dart:ui';

import 'package:cinema_club/features/setting/data/datasources/setting_local_data_source_impl.dart';
import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'setting_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SettingLocalDataSourceImpl localDataSourceImpl;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        SettingLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  const tsettingModel = SettingModel(isDarkMode: true, languageCode: 'en');

  test('should be SettingModel subclass from SettingEntity', () async {
    expect(tsettingModel, isA<SettingEntity>());
  });

  group('get Setting', () {
    test(
        'should return settingModel with default values when no preferences are set ',
        () async {
      when(mockSharedPreferences.getBool('theme_mode')).thenReturn(null);
      when(mockSharedPreferences.getString('language')).thenReturn(null);
      final result = await localDataSourceImpl.getSetting();
      expect(result.isDarkMode, false);
      expect(
          result.languageCode, PlatformDispatcher.instance.locale.languageCode);
    });
    test(
        'should return settingModel with stored value when preferences are set',
        () async {
      when(mockSharedPreferences.getBool('theme_mode'))
          .thenReturn(tsettingModel.isDarkMode);
      when(mockSharedPreferences.getString('language'))
          .thenReturn(tsettingModel.languageCode);
      final result = await localDataSourceImpl.getSetting();
      expect(result, tsettingModel);
      verify(mockSharedPreferences.getBool('theme_mode'));
      verify(mockSharedPreferences.getString('language'));
    });
  });
  group('saveSetting', () {
    test('should call SharedPreferences to save the the settings', () async {
      await localDataSourceImpl.saveSetting(tsettingModel);
      verify(mockSharedPreferences.setBool('theme_mode', true));
      verify(mockSharedPreferences.setString('language', 'en'));
    });
  });
}
