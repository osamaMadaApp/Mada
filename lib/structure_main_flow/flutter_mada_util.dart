import 'dart:io';
import 'dart:math' show pow, pi, sin;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

// import 'package:url_launcher/url_launcher.dart';

import '../general_exports.dart';
import 'uploaded_file.dart';

export 'dart:math' show min, max;
export 'dart:typed_data' show Uint8List;

export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

export '../app_state.dart';
export 'flutter_mada_model.dart';
export 'internationalization.dart' show FFLocalizations;
export 'nav/nav.dart';
export 'uploaded_file.dart';

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

void _setTimeagoLocales() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
}

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    _setTimeagoLocales();
    return timeago.format(dateTime, locale: locale, allowFromNow: true);
  }
  return DateFormat(format, locale).format(dateTime);
}

Future<FFUploadedFile> resizeImageIfNeeded(FFUploadedFile imageFile) async {
  const int maxSizeInBytes = 1024 * 1024; // 2MB

  final Uint8List? imageBytes = imageFile.bytes;
  if ((imageBytes?.lengthInBytes ?? 0) <= maxSizeInBytes) {
    // Image is already within the size limit
    return imageFile;
  }

  final img.Image? image = img.decodeImage(imageBytes ?? Uint8List(0));
  if (image == null) {
    throw Exception('Could not decode image');
  }

  int quality = 100;
  Uint8List? compressedBytes;

  // Compress image until it meets the size requirement
  do {
    compressedBytes =
        Uint8List.fromList(img.encodeJpg(image, quality: quality));
    quality -= 5;
  } while (compressedBytes.lengthInBytes > maxSizeInBytes && quality > 0);

  if (compressedBytes.lengthInBytes > maxSizeInBytes) {
    throw Exception('Could not compress image to required size');
  }
  final String newPath =
      imageFile.name?.replaceAll('.jpg', '_resized.jpg') ?? '';

  return FFUploadedFile(
      bytes: compressedBytes, name: newPath, blurHash: imageFile.blurHash);
}

Theme wrapInMaterialDatePickerTheme(
  BuildContext context,
  Widget child, {
  required Color headerBackgroundColor,
  required Color headerForegroundColor,
  required TextStyle headerTextStyle,
  required Color pickerBackgroundColor,
  required Color pickerForegroundColor,
  required Color selectedDateTimeBackgroundColor,
  required Color selectedDateTimeForegroundColor,
  required Color actionButtonForegroundColor,
  required double iconSize,
}) {
  final baseTheme = Theme.of(context);
  final dateTimeMaterialStateForegroundColor =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return pickerForegroundColor.withOpacity(0.60);
    }
    if (states.contains(WidgetState.selected)) {
      return selectedDateTimeForegroundColor;
    }
    if (states.isEmpty) {
      return pickerForegroundColor;
    }
    return null;
  });

  final dateTimeMaterialStateBackgroundColor =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return selectedDateTimeBackgroundColor;
    }
    return null;
  });

  return Theme(
    data: baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        onSurface: pickerForegroundColor,
      ),
      disabledColor: pickerForegroundColor.withOpacity(0.3),
      textTheme: baseTheme.textTheme.copyWith(
        headlineSmall: headerTextStyle,
        headlineMedium: headerTextStyle,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(
        size: iconSize,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              actionButtonForegroundColor,
            ),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return actionButtonForegroundColor.withOpacity(0.04);
              }
              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return actionButtonForegroundColor.withOpacity(0.12);
              }
              return null;
            })),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: pickerBackgroundColor,
        headerBackgroundColor: headerBackgroundColor,
        headerForegroundColor: headerForegroundColor,
        weekdayStyle: baseTheme.textTheme.labelMedium!.copyWith(
          color: pickerForegroundColor,
        ),
        dayBackgroundColor: dateTimeMaterialStateBackgroundColor,
        todayBackgroundColor: dateTimeMaterialStateBackgroundColor,
        yearBackgroundColor: dateTimeMaterialStateBackgroundColor,
        dayForegroundColor: dateTimeMaterialStateForegroundColor,
        todayForegroundColor: dateTimeMaterialStateForegroundColor,
        yearForegroundColor: dateTimeMaterialStateForegroundColor,
      ),
    ),
    child: child,
  );
}

Theme wrapInMaterialTimePickerTheme(
  BuildContext context,
  Widget child, {
  required Color headerBackgroundColor,
  required Color headerForegroundColor,
  required TextStyle headerTextStyle,
  required Color pickerBackgroundColor,
  required Color pickerForegroundColor,
  required Color selectedDateTimeBackgroundColor,
  required Color selectedDateTimeForegroundColor,
  required Color actionButtonForegroundColor,
  required double iconSize,
}) {
  final baseTheme = Theme.of(context);
  return Theme(
    data: baseTheme.copyWith(
      iconTheme: baseTheme.iconTheme.copyWith(
        size: iconSize,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              actionButtonForegroundColor,
            ),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return actionButtonForegroundColor.withOpacity(0.04);
              }
              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return actionButtonForegroundColor.withOpacity(0.12);
              }
              return null;
            })),
      ),
      timePickerTheme: baseTheme.timePickerTheme.copyWith(
        backgroundColor: pickerBackgroundColor,
        hourMinuteTextColor: pickerForegroundColor,
        dialHandColor: selectedDateTimeBackgroundColor,
        dialTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeForegroundColor
                : pickerForegroundColor),
        dayPeriodBorderSide: BorderSide(
          color: pickerForegroundColor,
        ),
        dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeForegroundColor
                : pickerForegroundColor),
        dayPeriodColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeBackgroundColor
                : Colors.transparent),
        entryModeIconColor: pickerForegroundColor,
      ),
    ),
    child: child,
  );
}

Future launchURL(String url) async {
  final uri = Uri.parse(url);
  try {
    // await launchUrl(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}


enum FormatType {
  decimal,
  percent,
  scientific,
  compact,
  compactLong,
  custom,
}

enum DecimalType {
  automatic,
  periodDecimal,
  commaDecimal,
}

String formatNumber(
  num? value, {
  required FormatType formatType,
  DecimalType? decimalType,
  String? currency,
  bool toLowerCase = false,
  String? format,
  String? locale,
}) {
  if (value == null) {
    return '';
  }
  var formattedValue = '';
  switch (formatType) {
    case FormatType.decimal:
      switch (decimalType!) {
        case DecimalType.automatic:
          formattedValue = NumberFormat.decimalPattern().format(value);
          break;
        case DecimalType.periodDecimal:
          if (currency != null) {
            formattedValue = NumberFormat('#,##0.00', 'en_US').format(value);
          } else {
            formattedValue = NumberFormat.decimalPattern('en_US').format(value);
          }
          break;
        case DecimalType.commaDecimal:
          if (currency != null) {
            formattedValue = NumberFormat('#,##0.00', 'es_PA').format(value);
          } else {
            formattedValue = NumberFormat.decimalPattern('es_PA').format(value);
          }
          break;
      }
      break;
    case FormatType.percent:
      formattedValue = NumberFormat.percentPattern().format(value);
      break;
    case FormatType.scientific:
      formattedValue = NumberFormat.scientificPattern().format(value);
      if (toLowerCase) {
        formattedValue = formattedValue.toLowerCase();
      }
      break;
    case FormatType.compact:
      formattedValue = NumberFormat.compact().format(value);
      break;
    case FormatType.compactLong:
      formattedValue = NumberFormat.compactLong().format(value);
      break;
    case FormatType.custom:
      final hasLocale = locale != null && locale.isNotEmpty;
      formattedValue =
          NumberFormat(format, hasLocale ? locale : null).format(value);
  }

  if (formattedValue.isEmpty) {
    return value.toString();
  }

  if (currency != null) {
    final currencySymbol = currency.isNotEmpty
        ? currency
        : NumberFormat.simpleCurrency().format(0.0).substring(0, 1);
    formattedValue = '$currencySymbol$formattedValue';
  }

  return formattedValue;
}

DateTime get getCurrentTimestamp => DateTime.now();

DateTime dateTimeFromSecondsSinceEpoch(int seconds) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

TimeOfDay get getCurrentTimeOfDayStamp => TimeOfDay.now();

extension DateTimeConversionExtension on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).round();
}

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);

  bool operator >(DateTime other) => isAfter(other);

  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);

  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

T? castToType<T>(dynamic value) {
  if (value == null) {
    return null;
  }
  switch (T) {
    case double:
      // Doubles may be stored as ints in some cases.
      return value.toDouble() as T;
    case int:
      // Likewise, ints may be stored as doubles. If this is the case
      // (i.e. no decimal value), return the value as an int.
      if (value is num && value.toInt() == value) {
        return value.toInt() as T;
      }
      break;
    default:
      break;
  }
  return value as T;
}



Rect? getWidgetBoundingBox(BuildContext context) {
  try {
    final renderBox = context.findRenderObject() as RenderBox?;
    return renderBox!.localToGlobal(Offset.zero) & renderBox.size;
  } catch (_) {
    return null;
  }
}

bool get isAndroid => !kIsWeb && Platform.isAndroid;

bool get isiOS => !kIsWeb && Platform.isIOS;

bool get isWeb => kIsWeb;

const kBreakpointSmall = 479.0;
const kBreakpointMedium = 767.0;
const kBreakpointLarge = 991.0;

bool isMobileWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kBreakpointSmall;

bool responsiveVisibility({
  required BuildContext context,
  bool phone = true,
  bool tablet = true,
  bool tabletLandscape = true,
  bool desktop = true,
}) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < kBreakpointSmall) {
    return phone;
  } else if (width < kBreakpointMedium) {
    return tablet;
  } else if (width < kBreakpointLarge) {
    return tabletLandscape;
  } else {
    return desktop;
  }
}

Future<void> bottomSheet(BuildContext context, FocusNode unFocusNode,
    {Widget? child, required bool isScrollControlled, required bool isDismissible}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
    isDismissible: isDismissible,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return GestureDetector(
        onTap: () => unFocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(unFocusNode)
            : FocusScope.of(context).unfocus(),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: child,
        ),
      );
    },
  );
}

Future<Future<Object?>> showLeftSideDrawer({
  required BuildContext context,
  required Widget child,
  String? title,
  bool? isDismissible,
}) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible ?? true,
    barrierLabel: "Dismiss",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: FlutterMadaTheme.of(context).colorFFFFFF,
            ),
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: child,
            ),
          ),
        ),
      ),
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation);
      return SlideTransition(
        position: slide,
        child: child,
      );
    },
  );
}


const kTextValidatorUsernameRegex = r'^[a-zA-Z][a-zA-Z0-9_-]{2,16}$';
// https://stackoverflow.com/a/201378
const kTextValidatorEmailRegex =
    "^(?:[a-zA-Z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$";
const kTextValidatorWebsiteRegex =
    r'(https?:\/\/)?(www\.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/)?(www\.)?(?!ww)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

extension FFTextEditingControllerExt on TextEditingController? {
  String get text => this == null ? '' : this!.text;

  set text(String newText) => this?.text = newText;
}

extension IterableExt<T> on Iterable<T> {
  List<T> sortedList<S extends Comparable>(
      {S Function(T)? keyOf, bool desc = false}) {
    final sortedAscending = toList()
      ..sort(keyOf == null ? null : ((a, b) => keyOf(a).compareTo(keyOf(b))));
    if (desc) {
      return sortedAscending.reversed.toList();
    }
    return sortedAscending;
  }

  List<S> mapIndexed<S>(S Function(int, T) func) => toList()
      .asMap()
      .map((index, value) => MapEntry(index, func(index, value)))
      .values
      .toList();
}

void setAppLanguage(BuildContext context, String language) {
  Provider.of<AppProvider>(context, listen: false).setLocale(language);
}

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) {
  Provider.of<AppProvider>(context, listen: false).setThemeMode(themeMode);
}

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

extension ListFilterExt<T> on Iterable<T?> {
  List<T> get withoutNulls => where((s) => s != null).map((e) => e!).toList();
}

extension MapFilterExtensions<T> on Map<String, T?> {
  Map<String, T> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value as T)),
      );
}

extension MapListContainsExt on List<dynamic> {
  bool containsMap(dynamic map) => map is Map
      ? any((e) => e is Map && const DeepCollectionEquality().equals(e, map))
      : contains(map);
}

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t, {bool Function(int)? filterFn}) => isEmpty
      ? []
      : (enumerate
          .map((e) => [e.value, if (filterFn == null || filterFn(e.key)) t])
          .expand((i) => i)
          .toList()
        ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);

  List<Padding> paddingTopEach(double val) =>
      map((w) => Padding(padding: EdgeInsets.only(top: val), child: w))
          .toList();
}

extension StatefulWidgetExtensions on State<StatefulWidget> {
  /// Check if the widget exist before safely setting state.
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}

// For iOS 16 and below, set the status bar color to match the app's theme.
// https://github.com/flutter/flutter/issues/41067
Brightness? _lastBrightness;

void fixStatusBarOniOS16AndBelow(BuildContext context) {
  if (!isiOS) {
    return;
  }
  final brightness = Theme.of(context).brightness;
  if (_lastBrightness != brightness) {
    _lastBrightness = brightness;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }
}

extension ListUniqueExt<T> on Iterable<T> {
  List<T> unique(dynamic Function(T) getKey) {
    final distinctSet = <dynamic>{};
    final distinctList = <T>[];
    for (var item in this) {
      if (distinctSet.add(getKey(item))) {
        distinctList.add(item);
      }
    }
    return distinctList;
  }
}

String roundTo(double value, int decimalPoints) {
  final power = pow(10, decimalPoints);
  return ((value * power).round() / power).toString();
}

double computeGradientAlignmentX(double evaluatedAngle) {
  evaluatedAngle %= 360;
  final rads = evaluatedAngle * pi / 180;
  double x;
  if (evaluatedAngle < 45 || evaluatedAngle > 315) {
    x = sin(2 * rads);
  } else if (45 <= evaluatedAngle && evaluatedAngle <= 135) {
    x = 1;
  } else if (135 <= evaluatedAngle && evaluatedAngle <= 225) {
    x = sin(-2 * rads);
  } else {
    x = -1;
  }
  return double.parse(roundTo(x, 2));
}

double computeGradientAlignmentY(double evaluatedAngle) {
  evaluatedAngle %= 360;
  final rads = evaluatedAngle * pi / 180;
  double y;
  if (evaluatedAngle < 45 || evaluatedAngle > 315) {
    y = -1;
  } else if (45 <= evaluatedAngle && evaluatedAngle <= 135) {
    y = sin(-2 * rads);
  } else if (135 <= evaluatedAngle && evaluatedAngle <= 225) {
    y = 1;
  } else {
    y = sin(2 * rads);
  }
  return double.parse(roundTo(y, 2));
}
