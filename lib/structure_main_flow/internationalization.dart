import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);

  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
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
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
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
    final language = locale.toString();
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

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginPage
  {
    'login': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'enterEmail': {
      'en': 'Enter your e-mail address to login',
      'ar': 'قم بادخال الايميل لتسجيل الدخول',
    },
    'forgetPassword': {
      'en': 'Forget Password',
      'ar': 'نسيت كلمة السر',
    },
    'rest': {
      'en': 'Enter your e-mail address to rest password',
      'ar': 'قم بادخال ايميلك لعادة تعيين كلمة السر',
    },
    'backToLogin': {
      'en': 'Back to login',
      'ar': 'العودة الى تسجيل الدخول',
    },
    'confirm': {
      'en': 'Confirm',
      'ar': 'موافقة',
    },
    'fillEmptyForm': {
      'en': 'Input Field is required',
      'ar': 'يرجى تعبئة الحقل الفارغ',
    },
    'emailIsNoValid': {
      'en': 'Input Field Email Is Not Valid',
      'ar': 'حقل الإدخال البريد الإلكتروني غير صالح',
    },
    'emailAddress': {
      'en': 'E-mail Address',
      'ar': 'البريد الالكتروني',
    },
    'forgetPassword?': {
      'en': 'Forget Password?',
      'ar': 'هل نسيت كلمة السر؟',
    },
    'password': {
      'en': 'Password',
      'ar': 'كلمة السر',
    },
    'bcdkouru': {
      'en': 'Sign in',
      'ar': 'تسجيل دخول',
    },
    '0wasfjru': {
      'en': 'Sign up',
      'ar': 'انشاء حساب',
    },
    'lggdo661': {
      'en': 'Home',
      'ar': '',
    },
    'code': {
      'en': 'Code Verification',
      'ar': 'التحقق من الرمز',
    },
    'enter': {
      'en': 'Enter the code that we sent to you on E-mail address',
      'ar': 'ادخل الرمز المرسل الى بريدك الالكتروني',
    },
    'resend': {
      'en': 'Resend the code',
      'ar': 'اعادة ارسال الرمز',
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
].reduce((a, b) => a..addAll(b));
