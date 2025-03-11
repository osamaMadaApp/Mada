import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/firebase_auth/auth_util.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'backend/firebase/firebase_config.dart';
import 'general_constants.dart';
import 'general_exports.dart';
import 'pages/home/home_page_widget.dart';
import 'pages/my_order_page/my_order_page.dart';
import 'pages/notifications_page/notifications_page.dart';
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

  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => appState,
    child: const MyApp(),
  ));
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

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    setIsRTL(context);
    final Map<String, dynamic> tabs = <String, dynamic>{
      'HomePage': const HomePage(),
      'MyOrderPage': const MyOrderPage(),
      'NotificationsPage': const NotificationsPage(),
      'MenuPage': const MenuPage(),
    };
    int currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: NavigationRail(
                  selectedIndex: currentIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentIndex = index;
                      _currentPageName = tabs.keys.toList()[index];
                    });
                  },
                  labelType: NavigationRailLabelType.none,
                  destinations: <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: currentIndex == 0
                            ? FlutterMadaTheme.of(context).coloreff5e6
                            : FlutterMadaTheme.of(context).colorFFFFFF,
                        elevation: currentIndex == 0 ? 4.0 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: currentIndex == 0
                              ? SvgPicture.asset(
                                  home,
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : SvgPicture.asset(
                                  homeDisabled,
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      label: Container(),
                    ),
                    NavigationRailDestination(
                      icon: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: currentIndex == 1
                            ? FlutterMadaTheme.of(context).coloreff5e6
                            : FlutterMadaTheme.of(context).colorFFFFFF,
                        elevation: currentIndex == 1 ? 4.0 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: currentIndex == 1
                              ? SvgPicture.asset(
                                  myOrders,
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : SvgPicture.asset(
                                  myOrdersDisabled,
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      label: Container(),
                    ),
                    NavigationRailDestination(
                      icon: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: currentIndex == 2
                            ? FlutterMadaTheme.of(context).coloreff5e6
                            : FlutterMadaTheme.of(context).colorFFFFFF,
                        elevation: currentIndex == 2 ? 4.0 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: currentIndex == 2
                              ? SvgPicture.asset(
                                  notification,
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : SvgPicture.asset(
                                  notificationDisabled,
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      label: Container(),
                    ),
                    NavigationRailDestination(
                      icon: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: currentIndex == 3
                            ? FlutterMadaTheme.of(context).coloreff5e6
                            : FlutterMadaTheme.of(context).colorFFFFFF,
                        elevation: currentIndex == 3 ? 4.0 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: currentIndex == 3
                              ? SvgPicture.asset(
                                  menu,
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : SvgPicture.asset(
                                  menuDisabled,
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      label: Container(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: SvgPicture.asset(
                  logo,
                  width: 56.0,
                  height: 56.0,
                ),
              )
            ],
          ),
          Expanded(
            child: tabs[_currentPageName] ?? const HomePage(),
          ),
        ],
      ),
    );
  }
}
