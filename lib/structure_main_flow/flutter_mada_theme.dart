// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kThemeModeKey = '__theme_mode__';
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
    final bool? darkMode = _prefs?.getBool(kThemeModeKey);
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

  /// Black
  late Color color000000;

  /// Light Gray
  late Color colorFFE4E5E8;

  /// Dark Blue
  late Color color3252a2;

  /// White
  late Color colorFFFFFF;

  /// Light Blue
  late Color colorFF605DEC;

  /// Light Gray
  late Color color91605DEC;

  /// Gray
  late Color colorFF627921;

  /// Light Green
  late Color coloreff5e6;

  /// Green
  late Color color8EC24D;

  /// Dark Gray
  late Color color292D32;

  /// Light Blue
  late Color colorE6EEF3;
  late Color color989898;
  late Color colorE1E1E1;
  late Color colorD9D9D9;

  /// Green
  late Color color97BE5A;

  /// Gray
  late Color colorF5F5F5;
  late Color colorD2D2D2;

  /// Gray
  late Color colorD2D2D240;

  /// Green
  late Color color97BE5A1A;
}

DeviceSize getDeviceSize(BuildContext context) {
  final double width = MediaQuery.sizeOf(context).width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

class LightModeTheme extends FlutterMadaTheme {
  @override
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;

  @override
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;

  @override
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  @override
  late Color primary = const Color(0xFF8EC24D);
  @override
  late Color color91605DEC = const Color(0xA039AFA9);
  @override
  late Color secondary = const Color(0xFF928163);
  @override
  late Color tertiary = const Color(0xFF6D604A);
  @override
  late Color alternate = const Color(0xFFC8D7E4);
  @override
  late Color primaryText = const Color(0xFF8EC24D);
  @override
  late Color secondaryText = const Color(0xFF384E58);
  @override
  late Color primaryBackground = const Color(0xFFF1F4F8);
  @override
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  @override
  late Color accent1 = const Color(0x4D4B986C);
  @override
  late Color accent2 = const Color(0x4D928163);
  @override
  late Color accent3 = const Color(0x4C6D604A);
  @override
  late Color accent4 = const Color(0xCDFFFFFF);
  @override
  late Color success = const Color(0xFF20C766);
  @override
  late Color warning = const Color(0xFFF3C344);
  @override
  late Color error = const Color(0xFFC4454D);
  @override
  late Color info = const Color(0xFFFFFFFF);
  @override
  late Color colorD9D9D9 = const Color(0xFFD9D9D9);

  @override
  late Color gray600 = const Color(0xFF6E7491);
  @override
  late Color colorFFE4E5E8 = const Color(0x80757575);
  @override
  late Color color000000 = const Color(0xFF000000);
  @override
  late Color color3252a2 = const Color(0xff1d5778);
  @override
  late Color colorFFFFFF = const Color(0xFFFFFFFF);
  @override
  late Color colorFF605DEC = const Color(0x1B605DEC);
  @override
  late Color colorFF627921 = const Color(0xFF626971);
  @override
  late Color coloreff5e6 = const Color(0xFFeff5e6);
  @override
  late Color color8EC24D = const Color(0xFF8EC24D);
  @override
  late Color color292D32 = const Color(0xFF292D32);
  @override
  late Color colorE6EEF3 = const Color(0xFFE6EEF3);
  @override
  late Color colorF5F5F5 = const Color(0xFFF5F5F5);
  @override
  late Color color989898 = const Color(0xFF989898);
  @override
  late Color colorE1E1E1 = const Color(0xFFE1E1E1);
  @override
  late Color color97BE5A = const Color(0xFF97BE5A);
  @override
  late Color colorD2D2D2 = const Color(0xFFD2D2D2);
  @override
  late Color colorD2D2D240 = const Color(0x40D2D2D2);
  @override
  late Color color97BE5A1A = const Color(0x97BE5A1A);
}

class DarkModeTheme extends FlutterMadaTheme {
  @override
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;

  @override
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;

  @override
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  @override
  late Color primary = const Color(0xFF605DEC);
}

class AppFonts {
  static const String workSans = 'WorkSans';
  static const String outfit = 'Outfit';

  static const FontWeight w400 = FontWeight.w400;
  static const FontWeight w500 = FontWeight.w500;
  static const FontWeight w600 = FontWeight.w600;
  static const FontWeight w700 = FontWeight.w700;
}
