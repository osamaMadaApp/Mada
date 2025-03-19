import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'components/forget_password_component/forget_password_component_model.dart';
import 'components/login_side_component/login_side_component_model.dart';
import 'components/otp_component/otp_component_model.dart';
import 'general_exports.dart';
import 'pages/login_page/login_page_model.dart';
import 'services/push_notification_service.dart';
import 'structure_main_flow/flutter_mada_util.dart';
import 'package:permission_handler/permission_handler.dart';

import 'backend/schema/util/schema_util.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;

bool get isIOS => !kIsWeb && Platform.isIOS;

bool get isWindows => !kIsWeb && Platform.isWindows;

bool get isWeb => kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final appProvider = AppProvider.instance;
  await appProvider.init();

  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  await PushNotificationService().setupInteractedMessage();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => appProvider),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoritesModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoginPageModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OtpComponentModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoginSideComponentModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ForgetPasswordComponentModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SearchScreenModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  consoleLog(await getFcmToken() ?? '', key: 'fcmToken');
}
