import 'dart:convert';
import 'dart:io';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:client_information/client_information.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../../../utils/ui_utils.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import '../../../api/api_keys.dart';
import '../../../structure_main_flow/flutter_mada_theme.dart';
import '../../../utils/log.dart';

export 'package:collection/collection.dart' show ListEquality;
export 'package:flutter/material.dart' show Color, Colors;

typedef StructBuilder<T> = T Function(Map<String, dynamic> data);

abstract class BaseStruct {
  Map<String, dynamic> toSerializableMap();

  String serialize() => json.encode(toSerializableMap());
}

const REGISTER_SAHIH_BUKHARI = 'REGISTER_SAHIH_BUKHARI';
const REGISTER_ARCHERY = 'REGISTER_ARCHERY';
const DONATION_FOR_PROJECT = 'DONATION_FOR_PROJECT';
const DETECT_LOCATION = 'DETECT_LOCATION';
const QraanEjaza = 'QraanEjaza';

Future<Map<String, dynamic>> getDeviceInfo() async {
  String? fcId;

  try {
    fcId = await FirebaseMessaging.instance.getToken();

    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    // Handle FormatException
    consoleLog('Caught a FormatException: $e');
  }

  final ClientInformation deviceInfo = await ClientInformation.fetch();
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    keyDeviceToken: fcId ?? '',
    keyDeviceType: Platform.isAndroid ? platformAndroid : platformIOS,
    keyDeviceId: deviceInfo.deviceId,
  };
  return data;
}

Future<String?>? getFcmToken() async {
  try {
    final String? token = await FirebaseMessaging.instance.getToken();
    return token;
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    // Handle FormatException
    consoleLog('Caught a FormatException: $e');
    return null;
  }
}

Future<Map<String, dynamic>> getDeviceQueryParams() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final ClientInformation deviceInfo = await ClientInformation.fetch();
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    keyDeviceModel: deviceInfo.osName,
    keyDeviceName: deviceInfo.deviceName,
    keyDeviceId: deviceInfo.deviceId,
    keyOsVersion: deviceInfo.osVersion,
    keyReleaseNo: packageInfo.buildNumber,
  };
  return data;
}

// Future performLogin(
//     {required BuildContext context,
//       String? email,
//       String? phoneNumber,
//       String? firstName,
//       String? lastName}) async {
//   ApiCallResponse? logincall;
//   ApiCallResponse? getUserByIdCall;
//   if (FFAppState().UserModel.accessRole.isEmpty) {
//   await  FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//       email: email!,
//       password: "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//
//   await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//       email: email!,
//       password: "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//
//     BaseAuthUser? userObject;
//     userObject = await authManager
//         .createAccountWithEmail(
//       context,
//       email!,
//       "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//     userObject ??= await authManager
//         .signInWithEmail(
//       context,
//       email,
//       "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//     User? userOn = FirebaseAuth.instance.currentUser;
//     String? idToken = await userOn?.getIdToken(true);
//     logincall = await MyCarApiGroupGroup.loginByEmailMerchantCall
//         .call(tokenId: idToken);
//     if (logincall.statusCode == 200) {
//       getUserByIdCall = await MyCarApiGroupGroup.getUserByIdCall
//           .call(authorization: logincall.jsonBody['data']['token']);
//       if (getUserByIdCall.statusCode == 200) {
//         UserModelStruct user = UserModelStruct.maybeFromMap(getJsonField(
//           (getUserByIdCall.jsonBody ?? ''),
//           r'''$.data''',
//         ))!;
//         FFAppState().UserModel =
//             user.copyWith(auth: logincall.jsonBody['data']['token']);
//       }
//       return Future.value("success");
//     }
//   } else {
//     return Future.value("success");
//   }
//   return Future.value("error");
// }
//
// Future performMyRequestCheckLogin(
//     {required BuildContext context,
//     String? typeOfBusiness,
//     String? email,
//     String? phoneNumber,
//     String? firstName,
//     String? lastName,
//     Position? position}) async {
//   ApiCallResponse? logincall;
//   ApiCallResponse? getUserByIdCall;
//   if (FFAppState().UserModel.accessRole.isEmpty) {
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//       email: email!,
//       password: "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//
//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//       email: email!,
//       password: "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//
//     BaseAuthUser? userObject;
//     userObject = await authManager
//         .createAccountWithEmail(
//       context,
//       email!,
//       "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//     userObject ??= await authManager
//         .signInWithEmail(
//       context,
//       email,
//       "123456dsd",
//     )
//         .then((onValue) {
//       print('');
//     }).catchError((onError) {
//       print('');
//     });
//     User? userOn = FirebaseAuth.instance.currentUser;
//     String? idToken = await userOn?.getIdToken(true);
//     logincall = await MyCarApiGroupGroup.loginByEmailMerchantCall
//         .call(tokenId: idToken);
//     if (logincall.statusCode == 200) {
//       getUserByIdCall = await MyCarApiGroupGroup.getUserByIdCall
//           .call(authorization: logincall.jsonBody['data']['token']);
//       if (getUserByIdCall.statusCode == 200) {
//         UserModelStruct user = UserModelStruct.maybeFromMap(getJsonField(
//           (getUserByIdCall.jsonBody ?? ''),
//           r'''$.data''',
//         ))!;
//         FFAppState().UserModel =
//             user.copyWith(auth: logincall.jsonBody['data']['token']);
//       }
//       return creatingEvent(
//           typeOfBusiness: typeOfBusiness ?? '', position: position);
//     }
//   } else {
//     return creatingEvent(
//         typeOfBusiness: typeOfBusiness ?? '', position: position);
//   }
//   return Future.value("error");
// }

// Future creatingEvent(
//     {required String typeOfBusiness, Position? position}) async {
//   ApiCallResponse? createInvolvingCall;
//   createInvolvingCall = await MyCarApiGroupGroup.createInvolvingCall.call(
//       authorization: FFAppState().UserModel.auth,
//       email: FFAppState().UserModel.emailAddress,
//       firstName: FFAppState().UserModel.name,
//       lastName: FFAppState().UserModel.name,
//       phoneNumber: FFAppState().UserModel.phoneNumber,
//       latitude: position?.latitude.toString(),
//       longitude: position?.longitude.toString(),
//       involvingType: typeOfBusiness);
//   if (createInvolvingCall.statusCode == 200) {
//     return Future.value("Success");
//   } else {
//     return Future.value("error");
//   }
// }

openNewTab({required String setUrl, required String setTitle}) {
  return html.window.open(
    setUrl,
    setTitle,
  );
}

dynamic deserializeStructParam<T>(
  dynamic param,
  ParamType paramType,
  bool isList, {
  required StructBuilder<T> structBuilder,
}) {
  if (param == null) {
    return null;
  } else if (isList) {
    final paramValues;
    try {
      paramValues = param is Iterable ? param : json.decode(param);
    } catch (e) {
      return null;
    }
    if (paramValues is! Iterable) {
      return null;
    }
    return paramValues
        .map<T>((e) => deserializeStructParam<T>(e, paramType, false,
            structBuilder: structBuilder))
        .toList();
  } else if (param is Map<String, dynamic>) {
    return structBuilder(param);
  } else {
    return deserializeParam<T>(
      param,
      paramType,
      isList,
      structBuilder: structBuilder,
    );
  }
}

List<T>? getStructList<T>(
  dynamic value,
  StructBuilder<T> structBuilder,
) =>
    value is! List
        ? null
        : value
            .whereType<Map<String, dynamic>>()
            .map((e) => structBuilder(e))
            .toList();

// Color? getSchemaColor(dynamic value) => value is String
//     ? fromCssColor(value)
//     : value is Color
//         ? value
//         : null;
//
// List<Color>? getColorsList(dynamic value) =>
//     value is! List ? null : value.map(getSchemaColor).withoutNulls;

List<T>? getDataList<T>(dynamic value) =>
    value is! List ? null : value.map((e) => castToType<T>(e)!).toList();

extension FilePathExtension on String {
  // Method to get the file name without extension
  String get fileName {
    return split('/').last.split('.').first;
  }

  // Method to get the file extension
  String get fileExtension {
    return split('.').last;
  }

  String get fileExtensionName {
    return '$fileName.$fileExtension';
  }
}

Future<void> error(
    BuildContext context, FocusNode unfocusNode, String? error) async {
  await showDialog<bool>(
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: SvgPicture.asset(
                  'assets/images/not_allowed.svg', //imlogosvg.svg
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getVariableText(
                    enText: 'Something went wrong !', arText: 'حصل خطأ ما'),
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: FlutterMadaTheme.of(context).color000000,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            child: Text(
              '$error' ?? '',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: FlutterMadaTheme.of(context).color000000,
                fontSize: 14.0,
                letterSpacing: 0.14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(alertDialogContext, true),
            child: Text(FFLocalizations.of(context).getVariableText(
              enText: 'Close',
              arText: 'اغلاق',
            )),
          ),
        ],
      );
    },
  );
}

Future<bool>? success(
    BuildContext context, FocusNode unfocusNode, String? body) async {
  return await showDialog<bool>(
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: SvgPicture.asset(
                  'assets/images/check.svg',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getVariableText(
                    enText: 'Successful Action', arText: 'عملية ناجحة'),
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: FlutterMadaTheme.of(context).color000000,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            child: Text(
              '$body' ?? '',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: FlutterMadaTheme.of(context).color000000,
                fontSize: 14.0,
                letterSpacing: 0.14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(alertDialogContext, true),
            child: Text(FFLocalizations.of(context).getVariableText(
              enText: 'Ok',
              arText: 'حسنا',
            )),
          ),
        ],
      );
    },
  ).then((onValue) {
    if (onValue != null) {
      return Future.value(onValue);
    } else {
      return Future.value(false);
    }
  });
}

extension TimestampToFormattedDate on int {
  String toFormattedDate({bool isMilliseconds = true}) {
    // Convert timestamp to DateTime (convert to milliseconds if in seconds)
    final DateTime dateTime = isMilliseconds
        ? DateTime.fromMillisecondsSinceEpoch(this)
        : DateTime.fromMillisecondsSinceEpoch(this * 1000);

    // Format date and time
    return DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
  }
}

extension StringToDateTime on String {
  /// Converts a string to DateTime using the provided format.
  DateTime toDateTime({String format = 'dd-MM-yyyy'}) {
    try {
      final dateFormat = DateFormat(format);
      return dateFormat.parse(this);
    } catch (e) {
      throw FormatException('Invalid date format. Expected: $format');
    }
  }
}

bool isExpirationDatePassed(int expirationTimestamp,
    {bool isMilliseconds = true}) {
  // Convert expiration timestamp to DateTime
  final DateTime expirationDate = isMilliseconds
      ? DateTime.fromMillisecondsSinceEpoch(expirationTimestamp)
      : DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);

  // Get current date
  final DateTime currentDate = DateTime.now();

  // Check if the expiration date has passed
  return currentDate.isAfter(expirationDate);
}

bool validateEnglishDigitsOnly(String input) {
  // Regular expression to match digits only
  final RegExp regex = RegExp(r'^[0-9]+(\.[0-9]+)?$');

  // Return true if input matches the pattern, otherwise false
  return regex.hasMatch(input);
}

bool checkDates(DateTime? firstDate, DateTime? secondDate) {
  if (firstDate!.isBefore(secondDate!) ||
      (firstDate.year == secondDate.year &&
          firstDate.month == secondDate.month &&
          firstDate.day == secondDate.day)) {
    return false;
  }
  return true;
}

enum ClassesType {
  hotelClass,
  transportationClass,
  travelClass,
  statusClass,
  eventClass,
}

enum TicketsStatus {
  pending,
  canceled,
  rejected,
  approved,
  edited,
  editedForRejection,
}

enum TopUpType {
  CART,
  SUBSCRIPTION,
  PURCHASE,
  BLOCK_TO_BOOK_FEES,
  VISA_FEES,
  EDIT_FEES,
  CANCEL_FEES,
}

extension RoutePathExtension on String {
  String toRoutePath() {
    if (isEmpty) return '/';
    return '/${this[0].toLowerCase()}${substring(1)}';
  }
}

enum TicketType { airline, hotel }

extension DateChecker on int {
  bool isFutureDate() {
    // Convert the timestamp (in milliseconds) to a DateTime object
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);

    // Get the current date and time
    final DateTime now = DateTime.now();

    // Return true if the date is in the future, otherwise false
    return dateTime.isAfter(now);
  }
}

extension DateCheckerExpired on String {
  bool isNotExpired() {
    try {
      // Parse the string into a DateTime object using the given format
      final dateParts = split('-');
      if (dateParts.length != 3) return false;

      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final inputDate = DateTime(year, month, day);

      // Get the current date (without time)
      final currentDate = DateTime.now();

      // Check if the date is before today
      final today =
          DateTime(currentDate.year, currentDate.month, currentDate.day);

      // Check if the date is today or in the future
      return inputDate.isAtSameMomentAs(today) || inputDate.isAfter(today);
    } catch (e) {
      // If parsing fails, return false
      return false;
    }
  }
}

String getTextByKey(String key, BuildContext context) {
  if (key == HOME) {
    return FFLocalizations.of(context)
        .getVariableText(enText: 'Home', arText: 'الرئيسية');
  } else if (key == contactUs) {
    return FFLocalizations.of(context)
        .getVariableText(enText: 'Contact Us', arText: 'تواصل معنا');
  } else {
    return FFLocalizations.of(context)
        .getVariableText(enText: 'Programs', arText: 'البرامج');
  }
}

RangeLabels formattedRangeLabels(
    RangeValues values, {
      String suffix = 'm²',
      bool price = false,
    }) {
  if (!price) {
    return RangeLabels(
      '${values.start.round().toString()} $suffix',
      '${values.end.round().toString()} $suffix',
    );
  } else {
    return RangeLabels(
      '${getFormattedPrice(values.start.round().toDouble())} $suffix',
      '${getFormattedPrice(values.end.round().toDouble())} $suffix',
    );
  }
}

const String HOME = 'home';
const String PROGRAM = 'program';
const String contactUs = 'contactUs';

int calculateNights(int startDateInt, int endDateInt) {
  final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startDateInt);
  final DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDateInt);

  final Duration difference = endDate.difference(startDate);
  final int nights = difference.inDays;
  return nights;
}

Widget totalView(
    {required BuildContext context,
    String? mainImage,
    String? title,
    String? subTitle,
    Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xff1E1E1E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Align(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(212),
                    ),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      mainImage ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/error_image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0, 15, 0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/images/more.png',
                    //lefte.png
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 5, 30, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            title ?? '',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontFamily: 'k2d',
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 5, 0.0, 5),
                        child: Wrap(
                          children: [
                            Text(
                              subTitle ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'k2d',
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 5.0, 0.0, 5),
                        child: Wrap(
                          children: [
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: 'Read More', arText: 'اقرأ المزيد'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontFamily: 'Inter',
                                color: Color(0xFF1A965C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                    height: 2,
                    color: const Color(0xFF1A965C),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
