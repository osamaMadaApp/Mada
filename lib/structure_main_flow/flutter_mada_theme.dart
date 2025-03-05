import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

enum DeviceSize {
  mobile,
  tablet,
  desktop,
}

abstract class FlutterMadaTheme {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterMadaTheme of(BuildContext context) {
    deviceSize = getDeviceSize(context);
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;

  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;

  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color gray600;
  late Color color000000;
  late Color colorFFE4E5E8;
  late Color color3252a2;
  late Color colorFFFFFF;
  late Color colorFF605DEC;
  late Color color91605DEC;
  late Color colorFF627921;
  late Color coloreff5e6;
}

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

class LightModeTheme extends FlutterMadaTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;

  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;

  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFD20001);
  late Color color91605DEC = const Color(0xA039AFA9);
  late Color secondary = const Color(0xFF928163);
  late Color tertiary = const Color(0xFF6D604A);
  late Color alternate = const Color(0xFFC8D7E4);
  late Color primaryText = const Color(0xFF6E7491);
  late Color secondaryText = const Color(0xFF384E58);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4D4B986C);
  late Color accent2 = const Color(0x4D928163);
  late Color accent3 = const Color(0x4C6D604A);
  late Color accent4 = const Color(0xCDFFFFFF);
  late Color success = const Color(0xFF20C766);
  late Color warning = const Color(0xFFF3C344);
  late Color error = const Color(0xFFC4454D);
  late Color info = const Color(0xFFFFFFFF);

  late Color gray600 = const Color(0xFF6E7491);
  late Color colorFFE4E5E8 = const Color(0x80757575);
  late Color color000000 = const Color(0xFF000000);
  late Color color3252a2 = const Color(0xff1d5778);
  late Color colorFFFFFF = const Color(0xFFFFFFFF);
  late Color colorFF605DEC = const Color(0x1B605DEC);
  late Color colorFF627921 = const Color(0xFF626971);
  late Color coloreff5e6 = const Color(0xFFeff5e6);
}

class DarkModeTheme extends FlutterMadaTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;

  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;

  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF605DEC);
  late Color secondary = const Color(0xFF928163);
  late Color tertiary = const Color(0xFF6D604A);
  late Color alternate = const Color(0xFF17282E);
  late Color primaryText = const Color(0xFF6E7491);
  late Color secondaryText = const Color(0xFF658593);
  late Color primaryBackground = const Color(0xFF0B191E);
  late Color secondaryBackground = const Color(0xFF0D1E23);
  late Color accent1 = const Color(0x4D4B986C);
  late Color accent2 = const Color(0x4D928163);
  late Color accent3 = const Color(0x4C6D604A);
  late Color accent4 = const Color(0xB20B191E);
  late Color success = const Color(0xFF20C766);
  late Color warning = const Color(0xFFF3C344);
  late Color error = const Color(0xFFC4454D);
  late Color info = const Color(0xFFFFFFFF);

  late Color gray600 = const Color(0xFF6E7491);
  late Color color000000 = const Color(0xFF000000);
  late Color color3252a2 = const Color(0xFF000000);
  late Color colorFFE4E5E8 = const Color(0x80757575);
  late Color colorFFFFFF = const Color(0xFFFFFFFF);
  late Color colorFF605DEC = const Color(0x1B605DEC);
  late Color color91605DEC = const Color(0x91605DEC);
  late Color colorFF627921 = const Color(0xFF626971);
}

extension FontExtensions on TextStyle {
  TextStyle withFont({
    required String fontFamily,
    FontWeight? fontWeight,
  }) {
    return copyWith(
      fontFamily: fontFamily,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}

class AppFonts {
  static const String poppins = 'Poppins';
  static const String k2d = 'K2d';
  static const String radioCanada = 'RadioCanada';
  static const String quicksand = 'Quicksand';
  static const String inter = 'Inter';
  static const String arimo = 'arimo';
  static const String lato = 'Lato';

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
