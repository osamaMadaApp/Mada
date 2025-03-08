import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => <String>['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final String? locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? <String, String>{})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      <String?>[enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = <String>{
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final String language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final Map<String, Map<String, String>> kTranslationsMap =
    <Map<String, Map<String, String>>>[
  // LoginPage
  <String, Map<String, String>>{
    'login': <String, String>{
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'bcdkouru': <String, String>{
      'en': 'Sign in',
      'ar': 'تسجيل دخول',
    },
    '0wasfjru': <String, String>{
      'en': 'Sign up',
      'ar': 'انشاء حساب',
    },
    'lggdo661': <String, String>{
      'en': 'Home',
      'ar': '',
    },
    'your_gateway_to_premium_life': <String, String>{
      'en': 'Your gateway to premium life',
      'ar': 'بوابتك إلى الحياة المتميزة',
    },
    'browse_out_main_categories': <String, String>{
      'en': 'Browse our main categories',
      'ar': 'تصفح الفئات الرئيسية لدينا',
    },
    'most_popular_projects': <String, String>{
      'en': 'Most popular projects',
      'ar': 'المشاريع الأكثر شعبية',
    },
  },
].reduce((Map<String, Map<String, String>> a,
            Map<String, Map<String, String>> b) =>
        a..addAll(b));
