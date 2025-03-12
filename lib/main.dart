import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/firebase_auth/auth_util.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'backend/firebase/firebase_config.dart';
import 'components/forget_password_component/forget_password_component_model.dart';
import 'components/login_side_component/login_side_component_model.dart';
import 'components/otp_component/otp_component_model.dart';
import 'general_exports.dart';
import 'pages/exclusive_projects/exclusive_projects_model.dart';
import 'pages/login_page/login_page_model.dart';
import 'structure_main_flow/flutter_mada_util.dart';
import 'structure_main_flow/internationalization.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;

bool get isIOS => !kIsWeb && Platform.isIOS;

bool get isWindows => !kIsWeb && Platform.isWindows;

bool get isWeb => kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await FlutterMadaTheme.initialize();

  final FFAppState appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSmartDialog(
        child: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider(create: (_) => AppStateNotifier.instance),
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
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = FlutterMadaTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier); // navigation
    setLocale(FFAppState().getSelectedLanguge());
    userStream = madaFirebaseUserStream()
      ..listen((BaseAuthUser user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterMadaTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1366),
      minTextAdapt: true, // Ensures text scales properly
      splitScreenMode: true, // Helps with split-screen support
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          title: 'Mada',
          localizationsDelegates: const <LocalizationsDelegate>[
            FFLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: const <Locale>[
            Locale('en'),
            Locale('ar'),
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodySmall: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              bodyMedium: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              bodyLarge: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            brightness: Brightness.light,
            useMaterial3: false,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: false,
          ),
          themeMode: _themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}

