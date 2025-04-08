import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'backend/schema/util/schema_util.dart';
import 'components/forget_password_component/forget_password_component_model.dart';
import 'components/login_side_component/login_side_component_model.dart';
import 'components/otp_component/otp_component_model.dart';
import 'general_exports.dart';
import 'pages/login_page/login_page_model.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;

bool get isIOS => !kIsWeb && Platform.isIOS;

bool get isWindows => !kIsWeb && Platform.isWindows;

bool get isWeb => kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  usePathUrlStrategy();

  final appProvider = AppProvider.instance;
  SchedulerBinding.instance.addPostFrameCallback((_) async {});
  await appProvider.init();

  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

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
      ],
      child: const MyApp(),
    ),
  );
  consoleLog(await getFcmToken() ?? '', key: 'fcmToken');
}
