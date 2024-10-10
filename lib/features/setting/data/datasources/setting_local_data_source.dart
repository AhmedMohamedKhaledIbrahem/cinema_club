import 'package:cinema_club/features/setting/data/models/setting_model.dart';

abstract class SettingLocalDataSource {
  Future<SettingModel> getSetting();
  Future<void> saveSetting(SettingModel settings);
}
