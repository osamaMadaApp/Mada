import 'dart:convert';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universal_html/html.dart' as html;

import '/structure_main_flow/flutter_mada_util.dart';
import '../../../auth/firebase_auth/auth_util.dart';
import '../../../structure_main_flow/flutter_mada_theme.dart';
import '../../../structure_main_flow/flutter_mada_widgets.dart';
import '../../api_requests/api_calls.dart';
import '../structs/user_model_struct.dart';

export 'package:collection/collection.dart' show ListEquality;
export 'package:flutter/material.dart' show Color, Colors;
export 'package:from_css_color/from_css_color.dart';

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

Future privacyAndPolicyBottom({required BuildContext context}) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
            child: RichText(
              text: TextSpan(
                text: FFLocalizations.of(context).getVariableText(
                  enText:
                      'We use cookies on our website to give you the most relevant experience by remembering your preferences and repeat visits. By clicking Accept All, you consent to the use of ALL cookies. However, you may visit Cookie Settings to provide controlled consent. For more information, please review our ',
                  arText:
                      'نحن نستخدم ملفات تعريف الارتباط على موقعنا لتقديم أفضل تجربة ممكنة من خلال تذكر تفضيلاتك وزياراتك المتكررة. بالنقر على  قبول الكل ، فإنك توافق على استخدام جميع ملفات تعريف الارتباط. ومع ذلك، يمكنك زيارة  إعدادات ملفات تعريف الارتباط  لتقديم موافقة مضبوطة. لمزيد من المعلومات، يرجى مراجعة ',
                ),
                style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.black,
                      letterSpacing: 0.0,
                    ),
                children: [
                  TextSpan(
                    text: FFLocalizations.of(context).getVariableText(
                      enText: 'Privacy Policy.',
                      arText: 'سياسة الخصوصية.',
                    ),
                    style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed('PrivacyAndPolicy');
                      },
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                child: FFButtonWidget(
                  onPressed: () async {
                    FFAppState().allowCookies = true;
                    context.pop(true);
                  },
                  text: FFLocalizations.of(context)
                      .getVariableText(enText: 'Accept', arText: 'موافقة'),
                  options: FFButtonOptions(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    color: FlutterMadaTheme.of(context).primary,
                    textStyle: const TextStyle(
                          fontSize: 15,
                          color: Color(0xddffffff),
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: FFButtonWidget(
                  onPressed: () async {
                    FFAppState().allowCookies = false;
                    context.pop(false);
                  },
                  text: FFLocalizations.of(context)
                      .getVariableText(enText: 'Reject', arText: 'رفض'),
                  options: FFButtonOptions(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    color: FlutterMadaTheme.of(context).error,
                    textStyle: const TextStyle(
                          fontSize: 15,
                          color: Color(0xddffffff),
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}




Future donateImage({required BuildContext context, String? path}) async {
  showDialog<bool>(
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: Text(FFLocalizations.of(context).getVariableText(
          enText: 'Scan To Donate',
          arText: 'قم بمسح الكود للتبرع',
        )),
        content: Image.asset(
          'assets/images/$path',
          fit: BoxFit.contain,
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

Future successErrorDialog(
    BuildContext context, dynamic onValue, String typeOfBusiness) async {
  if (onValue != null) {
    if (onValue == "Success") {
      String successText = '';
      if (typeOfBusiness == REGISTER_SAHIH_BUKHARI) {
        successText = FFLocalizations.of(context).getVariableText(
          enText:
              'Your request for registration on sahih bukhari is success. You will receive an email shortly with further details.',
          arText:
              'تم إرسال طلبك للاتحاق بصحيح بخاري، وستتلقى بريدًا إلكترونيًا قريبًا يحتوي على التفاصيل.',
        );
      } else if (typeOfBusiness == REGISTER_ARCHERY) {
        successText = FFLocalizations.of(context).getVariableText(
          enText:
              'Your request for registration to archery is  success. You will receive an email shortly with further details.',
          arText:
              'تم إرسال طلبك للالتحاق بقوس النشاب بشكل صحيح، وستتلقى بريدًا إلكترونيًا قريبًا يحتوي على التفاصيل.',
        );
      } else if (typeOfBusiness == DONATION_FOR_PROJECT) {
        successText = FFLocalizations.of(context).getVariableText(
          enText:
              'Your request for Donation is success. You will receive an email shortly with further details.',
          arText:
              'تم إرسال طلبك للتبرع بنجاح، وستتلقى بريدًا إلكترونيًا قريبًا يحتوي على التفاصيل.',
        );
      } else {
        successText = FFLocalizations.of(context).getVariableText(
          enText: 'Your request is submitted successfully',
          arText: 'تم ارسال الطلب بنجاح',
        );
      }
      return await showDialog<bool>(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text(FFLocalizations.of(context).getVariableText(
              enText: 'Success',
              arText: 'تهانينا',
            )),
            content: Text(successText),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext, true),
                child: Text(FFLocalizations.of(context).getVariableText(
                  enText: 'Confirm',
                  arText: 'موافق',
                )),
              ),
            ],
          );
        },
      );
    } else {
      return await showDialog<bool>(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text(FFLocalizations.of(context).getVariableText(
              enText: 'Error',
              arText: 'حصل خطب ما',
            )),
            content: Text(FFLocalizations.of(context).getVariableText(
              enText: 'Your request has Not been sent.',
              arText: 'لم يتم ارسال المعلومات بالشكل الصحيح',
            )),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext, true),
                child: Text(FFLocalizations.of(context).getVariableText(
                  enText: 'Confirm',
                  arText: 'موافق',
                )),
              ),
            ],
          );
        },
      );
    }
  }
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

Future creatingEvent(
    {required String typeOfBusiness, Position? position}) async {
  ApiCallResponse? createInvolvingCall;
  createInvolvingCall = await MyCarApiGroupGroup.createInvolvingCall.call(
      authorization: FFAppState().UserModel.auth,
      email: FFAppState().UserModel.emailAddress,
      firstName: FFAppState().UserModel.name,
      lastName: FFAppState().UserModel.name,
      phoneNumber: FFAppState().UserModel.phoneNumber,
      latitude: position?.latitude.toString(),
      longitude: position?.longitude.toString(),
      involvingType: typeOfBusiness);
  if (createInvolvingCall.statusCode == 200) {
    return Future.value("Success");
  } else {
    return Future.value("error");
  }
}

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

Color? getSchemaColor(dynamic value) => value is String
    ? fromCssColor(value)
    : value is Color
        ? value
        : null;

List<Color>? getColorsList(dynamic value) =>
    value is! List ? null : value.map(getSchemaColor).withoutNulls;

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

void error(BuildContext context, FocusNode unfocusNode, String? error) async {
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
    DateTime dateTime = isMilliseconds
        ? DateTime.fromMillisecondsSinceEpoch(this)
        : DateTime.fromMillisecondsSinceEpoch(this * 1000);

    // Format date and time
    return DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
  }
}

extension StringToDateTime on String {
  /// Converts a string to DateTime using the provided format.
  DateTime toDateTime({String format = "dd-MM-yyyy"}) {
    try {
      final dateFormat = DateFormat(format);
      return dateFormat.parse(this);
    } catch (e) {
      throw FormatException("Invalid date format. Expected: $format");
    }
  }
}

bool isExpirationDatePassed(int expirationTimestamp,
    {bool isMilliseconds = true}) {
  // Convert expiration timestamp to DateTime
  DateTime expirationDate = isMilliseconds
      ? DateTime.fromMillisecondsSinceEpoch(expirationTimestamp)
      : DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);

  // Get current date
  DateTime currentDate = DateTime.now();

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

enum TicketType { airline, hotel }

extension DateChecker on int {
  bool isFutureDate() {
    // Convert the timestamp (in milliseconds) to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);

    // Get the current date and time
    DateTime now = DateTime.now();

    // Return true if the date is in the future, otherwise false
    return dateTime.isAfter(now);
  }
}

extension DateCheckerExpired on String {
  bool isNotExpired() {
    try {
      // Parse the string into a DateTime object using the given format
      final dateParts = this.split('-');
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

const String HOME = 'home';
const String PROGRAM = 'program';
const String contactUs = 'contactUs';

int calculateNights(int startDateInt, int endDateInt) {
  DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startDateInt);
  DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDateInt);

  Duration difference = endDate.difference(startDate);
  int nights = difference.inDays;
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
      decoration: BoxDecoration(
        color: const Color(0xff1E1E1E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topLeft: const Radius.circular(0.0),
          topRight: const Radius.circular(0.0),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(212),
                      topLeft: const Radius.circular(0.0),
                      topRight: const Radius.circular(0.0),
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0, 15, 0),
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
              padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                            style: TextStyle(
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5, 0.0, 5),
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5),
                        child: Wrap(
                          children: [
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: 'Read More', arText: 'اقرأ المزيد'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    fontFamily: 'Inter',
                                    color: const Color(0xFF1A965C),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
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
