import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final _themekey = "ThemeMode";

  ThemeMode _currentThemeMode = ThemeMode.system;
  ThemeMode get currentThemeMode => _currentThemeMode;

  void changeThemeMode(ThemeMode mode) {
    if (currentThemeMode == mode) return;
    _currentThemeMode = mode;
    _saveThemeMode(mode.name);
    notifyListeners();
  }

  Future<void> loadInitialThemeMode() async {
    ThemeMode mode = await _getThemeMode();
    _currentThemeMode = mode;
    notifyListeners();
  }

  Future<void> _saveThemeMode(String mode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_themekey, mode);
  }

  Future<ThemeMode> _getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedThemeMode = sharedPreferences.getString(_themekey) ?? "";
    return getThemeModeFromString(savedThemeMode);
  }

  ThemeMode getThemeModeFromString(String value) {
    switch (value) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
