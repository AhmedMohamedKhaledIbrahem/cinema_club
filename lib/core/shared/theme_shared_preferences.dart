import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferences {
  static final ThemeSharedPreferences _instanec =
      ThemeSharedPreferences.internal();

  late SharedPreferences _preferences;

  factory ThemeSharedPreferences() {
    return _instanec;
  }
  ThemeSharedPreferences.internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences? get prefs => _preferences;

  // Save theme preference
  Future<void> setTheme(bool isDarkMode) async {
    await _preferences.setBool('isDarkMode', isDarkMode);
  }

  // Get theme preference
  bool? getTheme() {
    return _preferences.getBool('isDarkMode');
  }
}
