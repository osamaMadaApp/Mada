import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'components/forget_password_component/forget_password_component_model.dart';
import 'components/login_side_component/login_side_component_model.dart';
import 'components/otp_component/otp_component_model.dart';
import 'general_exports.dart';
import 'pages/exclusive_projects/exclusive_projects_model.dart';
import 'pages/login_page/login_page_model.dart';
import 'pages/projects_listview/projects_listview_model.dart';
import 'structure_main_flow/flutter_mada_util.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;

bool get isIOS => !kIsWeb && Platform.isIOS;

bool get isWindows => !kIsWeb && Platform.isWindows;

bool get isWeb => kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final appProvider = AppProvider.instance;
  await appProvider.init();

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => appProvider),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoritesModel(),
        ),

        // The bottom models should be deleted we don't want them globally
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
          create: (BuildContext context) => ExclusiveProjectsModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProjectsListviewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
