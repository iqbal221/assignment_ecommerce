import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String localkey = "locale";

  Locale _currentLocale = Locale("en");
  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale newLocale) {
    if (currentLocale == newLocale) return;
    _currentLocale = newLocale;
    _saveLocale(_currentLocale.languageCode);
    notifyListeners();
  }

  Future<void> loadInitialLanguage() async {
    Locale locale = await _getLocale();
    _currentLocale = locale;
    notifyListeners();
  }

  Future<void> _saveLocale(String locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(localkey, locale);
  }

  Future<Locale> _getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedLocale = sharedPreferences.getString(localkey) ?? "en";
    return Locale(savedLocale);
  }
}
