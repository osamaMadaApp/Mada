// // import 'dart:io';

// // import 'package:firebase_analytics/firebase_analytics.dart';
// // import 'package:package_info_plus/package_info_plus.dart';

// import 'dart:io';

// import 'package:client_information/client_information.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// import '../general_exports.dart';

// Map<String, dynamic> getDefaultQueryParams() {
//   final MyAppController myAppController = Get.find<MyAppController>();
//   Map<String, dynamic> data = <String, dynamic>{};
//   data = <String, dynamic>{
//     keyLangId: Get.find<MyAppController>().appLocale,
//     'sharedKey':
//         sharedKey, // If you uncomment this line, you will not get any response, don't know why
//     keyPlatform: Platform.isAndroid ? platformAndroid : platformIOS,
//     keyAppVersion: myAppController.buildNumber,
//   };
//   return data;
// }

// String getKeyBasedOnLanguage(String key) {
//   if (isRTL) {
//     return '${key}Ar';
//   } else {
//     return key;
//   }
// }

/// Formatted range labels above the range slider, it shows the suffix word above the value
// RangeLabels formattedRangeLabels(
//   RangeValues values, {
//   String suffix = 'm²',
//   bool price = false,
// }) {
//   if (!price) {
//     return RangeLabels(
//       '${values.start.round().toString()} ${suffix.tr}',
//       '${values.end.round().toString()} ${suffix.tr}',
//     );
//   } else {
//     return RangeLabels(
//       '${getFormattedPrice(values.start.round().toDouble())} ${suffix.tr}',
//       '${getFormattedPrice(values.end.round().toDouble())} ${suffix.tr}',
//     );
//   }
// }

// Future<Map<String, dynamic>> getDeviceQueryParams() async {
//   final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   final ClientInformation deviceInfo = await ClientInformation.fetch();
//   Map<String, dynamic> data = <String, dynamic>{};
//   data = <String, dynamic>{
//     keyDeviceModel: deviceInfo.osName,
//     keyDeviceName: deviceInfo.deviceName,
//     keyDeviceId: deviceInfo.deviceId,
//     keyOsVersion: deviceInfo.osVersion,
//     keyReleaseNo: packageInfo.buildNumber,
//   };
//   return data;
// }

// void openWebview(
//   String key, {
//   String code = 'not_pdf',
//   String title = '',
// }) {
//   //final MyAppController myAppController = Get.find<MyAppController>();

//   Get.toNamed(
//     routeWebviewScreen,
//     arguments: <String, dynamic>{
//       keyUrl: code == 'pdf' ? key : Uri.parse(key),
//       keyCode: code,
//       keyTitle: title,
//     },
//   );
// }

const List<String> allCountries = <String>[
  'AF',
  'AL',
  'DZ',
  'AS',
  'AD',
  'AO',
  'AI',
  'AG',
  'AR',
  'AM',
  'AW',
  'AU',
  'AT',
  'AZ',
  'BS',
  'BH',
  'BD',
  'BB',
  'BY',
  'BE',
  'BZ',
  'BJ',
  'BM',
  'BT',
  'BO',
  'BA',
  'BW',
  'BR',
  'IO',
  'VG',
  'BN',
  'BG',
  'BF',
  'BI',
  'KH',
  'CM',
  'CA',
  'CV',
  'KY',
  'CF',
  'TD',
  'CL',
  'CN',
  'CO',
  'KM',
  'CG',
  'CD',
  'CK',
  'CR',
  'CI',
  'HR',
  'CU',
  'CY',
  'CZ',
  'DK',
  'DJ',
  'DM',
  'DO',
  'EC',
  'EG',
  'SV',
  'GQ',
  'ER',
  'EE',
  'SZ',
  'ET',
  'FJ',
  'FI',
  'FR',
  'GF',
  'PF',
  'GA',
  'GM',
  'GE',
  'DE',
  'GH',
  'GI',
  'GR',
  'GL',
  'GD',
  'GP',
  'GU',
  'GT',
  'GG',
  'GN',
  'GW',
  'GY',
  'HT',
  'HN',
  'HK',
  'HU',
  'IS',
  'IN',
  'ID',
  'IR',
  'IQ',
  'IE',
  'IM',
  'IL',
  'IT',
  'JM',
  'JP',
  'JE',
  'JO',
  'KZ',
  'KE',
  'KI',
  'KP',
  'KR',
  'KW',
  'KG',
  'LA',
  'LV',
  'LB',
  'LS',
  'LR',
  'LY',
  'LI',
  'LT',
  'LU',
  'MO',
  'MK',
  'MG',
  'MW',
  'MY',
  'MV',
  'ML',
  'MT',
  'MH',
  'MQ',
  'MR',
  'MU',
  'YT',
  'MX',
  'FM',
  'MD',
  'MC',
  'MN',
  'ME',
  'MS',
  'MA',
  'MZ',
  'MM',
  'NA',
  'NR',
  'NP',
  'NL',
  'NC',
  'NZ',
  'NI',
  'NE',
  'NG',
  'NU',
  'NF',
  'MP',
  'NO',
  'OM',
  'PK',
  'PW',
  'PS',
  'PA',
  'PG',
  'PY',
  'PE',
  'PH',
  'PL',
  'PT',
  'PR',
  'QA',
  'RE',
  'RO',
  'RU',
  'RW',
  'WS',
  'SM',
  'ST',
  'SA',
  'SN',
  'RS',
  'SC',
  'SL',
  'SG',
  'SX',
  'SK',
  'SI',
  'SB',
  'SO',
  'ZA',
  'SS',
  'ES',
  'LK',
  'BL',
  'SH',
  'KN',
  'LC',
  'MF',
  'PM',
  'VC',
  'SD',
  'SR',
  'SE',
  'CH',
  'SY',
  'TW',
  'TJ',
  'TZ',
  'TH',
  'TL',
  'TG',
  'TO',
  'TT',
  'TN',
  'TR',
  'TM',
  'TC',
  'TV',
  'UG',
  'UA',
  'AE',
  'GB',
  'US',
  'UY',
  'UZ',
  'VU',
  'VA',
  'VE',
  'VN',
  'VI',
  'YE',
  'ZM',
  'ZW',
  'AX',
  'AC',
  'BQ',
  'CX',
  'CC',
  'FK',
  'FO',
  'HM',
  'XK',
  'GS',
  'SJ',
  'TK',
  'WF',
  'EH',
  'CW',
];

// String getCurrency() {
//   final MyAppController myAppController = Get.find<MyAppController>();
//   return myAppController.masterData[keyCurrency];
// }

// String getUnitOfMeasure() {
//   final MyAppController myAppController = Get.find<MyAppController>();
//   if (myAppController.appCountry == 'SA') {
//     return 'sqm'.tr;
//   } else {
//     return 'sqft'.tr;
//   }
// }

// String getFormattedPrice(double price) {
//   return NumberFormat('#,##0').format(price);
// }

bool areMapsEqual(Map? map1, Map? map2) {
  if (map1 == null || map2 == null) return false;
  if (map1.length != map2.length) return false;
  for (var key in map1.keys) {
    if (map1[key] != map2[key]) return false;
  }
  return true;
}
