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

// Future<void> openOrdersScreen({dynamic id}) async {
//   Get.offAllNamed(routeBottomBar);
//   if (id != null) {
//     Get.toNamed(
//       routeOrdersDetails,
//       arguments: id,
//     );
//   } else {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
//     Get.find<BottomBarController>().onBottomBarItemPressed(3);
//   }
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

void openScreenBasedOnScreenName(String screenName, dynamic value) {
  // if (screenName == projectDetailsScreen) {
  //   Get.toNamed(
  //     routeProjectDetails,
  //     arguments: value,
  //   );
  // } else if (screenName == blogDetailsScreen) {
  //   Get.toNamed(
  //     routeBlogDetails,
  //     arguments: value,
  //   );
  // } else if (screenName == unitDetailsScreen) {
  //   Get.toNamed(
  //     routeUnitDetails,
  //     arguments: {
  //       keyID: value,
  //     },
  //   );
  // } else if (screenName == propertyDetailsScreen) {
  //   Get.to(
  //     const PropertyDetails(),
  //     arguments: value,
  //   );
  // } else if (screenName == webViewScreen) {
  //   Get.toNamed(
  //     routeWebViewScreen,
  //     arguments: {
  //       keyUrl: value,
  //     },
  //   );
  // }
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

// bool shouldShowTimer(dynamic item) =>
//     item![keyPublishSeconds] != null &&
//     item![keyPublishSeconds].toString().isNotEmpty &&
//     item![keyPublishSeconds].toString() != '0' &&
//     !item![keyPublishSeconds].toString().contains('-');

// String getDaysFromSeconds(int seconds) =>
//     (seconds ~/ (24 * 60 * 60)).toString();

// String getHoursFromSeconds(int seconds) =>
//     (seconds ~/ (60 * 60) % 24).toString();

// String getMinutesFromSecondsWithoutPad(int seconds) =>
//     ((seconds % 3600) ~/ 60).toString();

// String getFormattedSecondsWithoutPad(int seconds) => (seconds % 60).toString();

// String calculateTimeDifference(String lastDate, String lastTime) {
//   consoleLog(lastTime);
//   final DateTime lastDateTime =
//       DateFormat('dd-MM-yyyy HH:mm:ss').parse('$lastDate $lastTime');

//   final DateTime now = DateTime.parse(getDateTimeInSaudiArabia());

//   final Duration difference = now.difference(lastDateTime);

//   if (difference.inMinutes < 60) {
//     return '${difference.inMinutes} ${'minute_ago'.tr}';
//   } else if (difference.inHours < 24) {
//     return '${difference.inHours} ${'hours_ago'.tr}';
//   } else {
//     return '${difference.inDays} ${'days_ago'.tr}';
//   }
// }

// String formatDateTimeInSaudiArabia(DateTime dateTime) {
//   final Location saudiArabia = getLocation('Asia/Riyadh');
//   final TZDateTime saudiDateTime = TZDateTime.from(dateTime, saudiArabia);
//   final String formattedDateTime =
//       DateFormat('yyyy-MM-dd HH:mm:ss').format(saudiDateTime);
//   return formattedDateTime;
// }

// String getDateTimeInSaudiArabia() {
//   final Location saudiArabia = getLocation('Asia/Riyadh');
//   final TZDateTime nowInSaudiArabia = TZDateTime.now(saudiArabia);

//   // Log the formatted date and time in Saudi Arabia
//   final String formattedNow = formatDateTimeInSaudiArabia(nowInSaudiArabia);
//   consoleLog(formattedNow, key: 'now in saudi');

//   return formattedNow;
// }

// String formatNotificationDate(String notificationsDate) {
//   final DateFormat dateFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');

//   DateTime notificationDateTime;
//   try {
//     notificationDateTime = dateFormat.parse(notificationsDate);
//   } catch (e) {
//     return notificationsDate;
//   }

//   final DateTime now = DateTime.now();

//   final Duration difference = now.difference(notificationDateTime);

//   if (difference.inHours >= 24) {
//     // If more than 24 hours have passed, return the original string
//     return notificationsDate;
//   } else {
//     // If less than 24 hours, return only the time part
//     final String formattedTime =
//         DateFormat('h:mm a').format(notificationDateTime);
//     return formattedTime;
//   }
// }

// String removeDecimalZeroFormat(double n) {
//   return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
// }

// Future<void> shareQrCode(String linkUrl, String text) async {
//   final Uint8List? qrCodeImage = await captureQrCode(linkUrl);

//   if (qrCodeImage != null && linkUrl.isNotEmpty) {
//     final Directory tempDir = await getTemporaryDirectory();
//     final File tempFile = File('${tempDir.path}/qr_code.png');
//     await tempFile.writeAsBytes(qrCodeImage);

//     await Share.shareXFiles(
//       <XFile>[XFile(tempFile.path)],
//       subject: text,
//       text: Platform.isAndroid ? text : null,
//     );
//   } else {
//     showToast(message: 'error_happened'.tr);
//   }
// }

// Future<Uint8List?> captureQrCode(String linkUrl,
//     {double qrCodeSize = 300.0, double margin = 25.0}) async {
//   // Load your logo image from the assets
//   final ByteData data = await rootBundle.load('assets/images/white_logo.jpg');
//   final List<int> bytes = data.buffer.asUint8List();
//   final ui.Image embeddedImage =
//       await decodeImageFromList(Uint8List.fromList(bytes));

//   // Generate QR code image with embeddedImage
//   final ui.Image qrCodeImage = await QrPainter(
//     data: linkUrl,
//     version: QrVersions.auto,
//     color: const Color(AppColors.blue2),
//     embeddedImage: embeddedImage,
//     embeddedImageStyle: const QrEmbeddedImageStyle(
//       size: Size(60, 55),
//       color: Color(
//         AppColors.transparent,
//       ),
//     ),
//   ).toImage(qrCodeSize.toDouble());

//   // Create a new PictureRecorder and Canvas for overlaying the QR code and logo
//   final ui.PictureRecorder recorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(recorder);

//   // Draw a white background
//   canvas.drawColor(const Color(AppColors.white), BlendMode.src);

//   // Calculate the position to center the QR code on the canvas with a margin
//   final double qrCodeX = margin;
//   final double qrCodeY = margin;

//   // Draw the QR code onto the canvas with a margin
//   canvas.drawImage(
//     qrCodeImage,
//     Offset(qrCodeX, qrCodeY),
//     Paint(),
//   );

//   // Convert the canvas to an image
//   final ui.Image finalImage = await recorder.endRecording().toImage(
//         (qrCodeSize + 2 * margin).toInt(),
//         (qrCodeSize + 2 * margin).toInt(),
//       );
//   final ByteData? byteData =
//       await finalImage.toByteData(format: ui.ImageByteFormat.png);

//   return byteData?.buffer.asUint8List();
// }

// void redirectDynamicLink(PendingDynamicLinkData dynamicLink) {
//   final MyAppController myAppController = Get.find<MyAppController>();
//   final String deepLink = dynamicLink.link.toString();
//   final Map<String, String> queryParameters = dynamicLink.link.queryParameters;
//   consoleLog(deepLink.toString(), key: 'deepLink');
//   consoleLog(queryParameters, key: 'deep_link_query_parameters');
//   Future<void>.delayed(const Duration(milliseconds: 200));

//   if (queryParameters.containsKey('trackingCode')) {
//     final String trackingCode = queryParameters['trackingCode'] ?? '';
//     final int isShowCode = int.parse(queryParameters['isShowCode'] ?? '0');
//     myAppController.onTrackingCodeUpdated(trackingCode);
//     myAppController.onIsShowCodeUpdated(isShowCode);
//   }

//   if (queryParameters.containsKey('promoCode')) {
//     final String promoCode = queryParameters['promoCode'] ?? '';
//     final int isShowDiscountCode = int.parse(
//       queryParameters['isShowPromoCode'] ?? '0',
//     );
//     myAppController.onPromoCodeUpdated(promoCode);
//     myAppController.onIsShowPromoCodeUpdated(isShowDiscountCode);
//   }

//   final int id = int.parse(queryParameters[keyId] ?? '0');
//   consoleLog(id);
//   myAppController.changeSource('Link');
//   if (deepLink.contains(ownerShareLink)) {
//     Get.toNamed(routeCompanyProfile, arguments: <String, dynamic>{keyId: id});
//   } else if (deepLink.contains(drawingShareLink)) {
//     Get.toNamed(routeLayoutDetails, arguments: id);
//   } else if (deepLink.contains(clientRequestDetails)) {
//     Get.toNamed(routeOrdersDetails, arguments: id);
//   } else if (deepLink.contains(clientNotification)) {
//     Get.toNamed(routeNotifications);
//   } else if (deepLink.contains(propertyShareLink)) {
//     Get.toNamed(routeLandDetails, arguments: id);
//   } else if (deepLink.contains(housingProjectShareLink)) {
//     Get.toNamed(routeHousingUnitDetails, arguments: id);
//   } else if (deepLink.contains(housingUnitShareLink)) {
//     Get.toNamed(routeApartmentDetails, arguments: id);
//   } else if (deepLink.contains(megaScreenShareLink)) {
//     Get.toNamed(routeMegaProjectDetails, arguments: id);
//   }
// }

// Future<BitmapDescriptor> getResizedMarkerIcon(
//   String url,
//   int width,
//   int height,
// ) async {
//   final Directory documentDirectory = await getApplicationDocumentsDirectory();
//   final String name =
//       '${url.substring(url.lastIndexOf('/') + 1).split('.').first}.png';
//   // check if the file already exits
//   final File file = await File('${documentDirectory.path}/$name').exists()
//       ? File('${documentDirectory.path}/$name')
//       : await fileFromImageUrl(url, name);

//   // Compress the image
//   final Uint8List? compressedBytes =
//       await FlutterImageCompress.compressWithFile(
//     file.absolute.path,
//     minWidth: width,
//     minHeight: height,
//     format: CompressFormat.png,
//   );

//   // Convert to BitmapDescriptor
//   return BitmapDescriptor.fromBytes(compressedBytes!);
// }

// Future<File> fileFromImageUrl(String url, String fileName) async {
//   final http.Response response = await http.get(Uri.parse(url));

//   final Directory documentDirectory = await getApplicationDocumentsDirectory();

//   final File file = File('${documentDirectory.path}/$fileName');

//   file.writeAsBytesSync(response.bodyBytes);

//   return file;
// }
