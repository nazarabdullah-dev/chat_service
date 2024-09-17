import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PrefManager {
  static const String _localeKey = 'locale';
  static const String _localeModeKey = 'locale_mode';

  static Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  static Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    return languageCode != null ? Locale(languageCode) : const Locale('en');
  }
}
