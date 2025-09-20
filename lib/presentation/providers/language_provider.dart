import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';

  Locale _currentLocale = const Locale('fr'); // Français par défaut

  Locale get currentLocale => _currentLocale;

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'fr';
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> changeLanguage(Locale locale) async {
    if (_currentLocale == locale) return;

    _currentLocale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
  }

  bool get isFrench => _currentLocale.languageCode == 'fr';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  List<Locale> get supportedLocales => const [
    Locale('fr'),
    Locale('en'),
  ];
}