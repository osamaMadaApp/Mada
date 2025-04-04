import 'dart:async';
import 'dart:ui' as ui;

// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../general_exports.dart';
import '../structure_main_flow/flutter_mada_util.dart';

void hideKeyboard() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

String getFontFamily(String languageCode) {
  String fontFamily = 'Outfit';

  if (languageCode.toLowerCase() == 'ar') {
    fontFamily = 'Tajawal';
  }

  return fontFamily;
}

bool areMapsEqual(Map? map1, Map? map2) {
  if (map1 == null || map2 == null) return false;
  if (map1.length != map2.length) return false;
  for (var key in map1.keys) {
    if (map1[key] != map2[key]) return false;
  }
  return true;
}

bool isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

// Future<void> openUrl(String url) async {
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(
//       Uri.parse(url),
//       mode: LaunchMode.externalApplication,
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }
// void openSelectSheet(
//   List<dynamic> list,
//   Function(dynamic)? onTap,
//   String key,
// ) {
//   Get.bottomSheet(
//     BottomSheetContainer(
//       child: Column(
//         children: <Widget>[
//           ...list.map(
//             (dynamic item) {
//               return TextSheetItem(
//                 text: item[key] ?? '',
//                 onTap: () {
//                   onTap?.call(item);
//                   Get.back();
//                 },
//               );
//             },
//           )
//         ],
//       ),
//     ),
//     isScrollControlled: true,
//   );
// }

// void openCustomSheet(
//   Widget child, {
//   bool isDismissible = true,
//   bool withCloseButton = true,
//   bool enableDrag = true,
// }) {
//   Get.bottomSheet(
//     BottomSheetContainer(
//       withCloseButton: withCloseButton,
//       child: child,
//     ),
//     isDismissible: isDismissible,
//     enableDrag: enableDrag,
//     isScrollControlled: true,
//   );
// }

// /// Formatted range labels above the range slider, it shows the suffix word above the value
// RangeLabels formattedRangeLabels(
//   RangeValues values, {
//   String suffix = 'rial',
// }) {
//   return RangeLabels(
//     '${values.start.round().toString()} ${suffix.tr}',
//     '${values.end.round().toString()} ${suffix.tr}',
//   );
// }

// void changeStatusBarBrightness(Brightness brightness) {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarIconBrightness: brightness,
//       systemNavigationBarIconBrightness: brightness,
//     ),
//   );
// }

// PreferredSize aqarekAppBar(
//   String title, {
//   List<Widget>? actions,
//   bool withBorderRadius = true,
//   bool withBack = true,
//   String? subtitle,
//   String? logoPath,
//   Function()? onBackPress,
// }) =>
//     PreferredSize(
//       preferredSize: Size.fromHeight(DEVICE_HEIGHT * 0.08),
//       child: AppBar(
//         title: Row(
//           children: <Widget>[
//             if (logoPath != null)
//               Row(
//                 children: <Widget>[
//                   Image.asset(
//                     logoPath,
//                     height: DEVICE_HEIGHT * 0.04,
//                   ),
//                   SizedBox(
//                     width: DEVICE_WIDTH * 0.05,
//                   ),
//                 ],
//               ),
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   Text(
//                     title,
//                     style:
//                         Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
//                               color: Colors.white,
//                             ),
//                   ),
//                   if (subtitle != null)
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: DEVICE_WIDTH * 0.02,
//                       ),
//                       child: Text(
//                         subtitle,
//                         style: Theme.of(Get.context!)
//                             .textTheme
//                             .bodyMedium!
//                             // .copyWith(
//                               color: Colors.white,
//                             ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: actions,
//         backgroundColor: const Color(AppColors.blue2),
//         leading: withBack
//             ? IconButton(
//                 icon: RotatedBox(
//                   quarterTurns: isRTL ? 0 : 2,
//                   child: SvgPicture.asset(iconGrayBack),
//                 ),
//                 onPressed: onBackPress ?? Get.back,
//               )
//             : null,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(
//               withBorderRadius ? DEVICE_HEIGHT * 0.005 : 0.0,
//             ), // Adjust the radius as needed
//           ),
//         ),
//       ),
//     );

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

// String propertyCodeSuffix(dynamic item) => item.containsKey(keyBuildingNo)
//     ? (item?[keyBuildingNo] ?? '')
//     : (item?[keyBlockName] ?? '');

// Future<void> openMap(
//   double latitude,
//   double longitude, {
//   LaunchMode linkLaunchMode = LaunchMode.externalApplication,
// }) async {
//   final String googleUrl =
//       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//   if (await canLaunchUrl(Uri.parse(googleUrl))) {
//     await launchUrl(Uri.parse(googleUrl), mode: linkLaunchMode);
//   } else {
//     throw 'Could not open the map.';
//   }
// }

// String getFormattedSeconds(int seconds) => (seconds % 60).toString().padLeft(
//       2,
//       '0',
//     );

// String getMinutesFromSeconds(int seconds) =>
//     ((seconds % 3600) ~/ 60).toString().padLeft(
//           2,
//           '0',
//         );

String hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');

  hexColor = '0xFF$hexColor';

  return hexColor;
}

Color hexToColor2(String hex) {
  hex = hex.replaceAll('#', ''); // Remove #
  if (hex.length == 6) {
    hex = 'FF$hex'; // Add alpha if missing
  }
  return Color(int.parse('0x$hex'));
}

String getStringJoinedByDash(List<dynamic> items, String key) =>
    items.map((dynamic item) => item[key]).join(' - ');

List<dynamic> getListFromKey(List<dynamic> list, String key) =>
    list.map((dynamic item) => item[key]).toList();

String getFormattedPrice(double price) {
  return NumberFormat('#,##0').format(price);
}

String getCurrency() {
  return FFAppState().masterDateJsonModel[keyCurrency] ?? 'SAR';
}

String getUnitOfMeasure(BuildContext context) {
  // final MyAppController myAppController = Get.find<MyAppController>();
  // if (myAppController.appCountry == 'SA') {
  //   return 'sqm'.tr;
  // } else {
  return FFLocalizations.of(context).getText('sqft');
  // }
}

void openScreenBasedOnScreenName(
  String screenName,
  dynamic value,
  BuildContext context,
) {
  if (screenName == projectDetailsScreen) {
    Navigator.pushNamed(
      context,
      Routes.routeProjectDetails,
      arguments: {
        keyProjectId: value,
      },
    );
  } else if (screenName == unitDetailsScreen) {
    Navigator.pushNamed(
      context,
      Routes.routeUnitDetails,
      arguments: {
        keyID: value,
      },
    );
  } else if (screenName == propertyDetailsScreen) {
    Navigator.pushNamed(
      context,
      Routes.routePropertyDetails,
      arguments: {
        keyPropertyId: value,
      },
    );
  } else if (screenName == webViewScreen) {
    Navigator.pushNamed(
      context,
      Routes.routeWebViewScreen,
      arguments: {
        keyUrl: value,
      },
    );
  }
}

Future<Uint8List> getMarkerImage(String path, int width) async {
  final ByteData data = await rootBundle.load(path);
  final ui.Codec codec = await ui
      .instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
  final ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
