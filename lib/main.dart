import 'dart:io' show Platform;

import 'package:Mada/pages/home/home_page.dart';
import 'package:Mada/pages/like/like_page.dart';
import 'package:Mada/pages/search/search_page.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import '/structure_main_flow/flutter_mada_theme.dart';
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

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
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
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 0),
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
    return MaterialApp.router(
      title: 'Mada',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
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
    final tabs = {
      'HomePage': const HomePage(),
      'LikePage': const LikePage(),
      'SearchPage': const SearchPage(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: currentIndex == 0 ? Colors.orange : Colors.white,
              elevation: currentIndex == 0 ? 4.0 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Icon(
                  Icons.home_outlined,
                  size: 24.0,
                ),
              ),
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: currentIndex == 1 ? Colors.orange : Colors.white,
              elevation: currentIndex == 1 ? 4.0 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Icon(
                  Icons.favorite_outline,
                  size: 24.0,
                ),
              ),
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: currentIndex == 2 ? Colors.orange : Colors.white,
              elevation: currentIndex == 2 ? 4.0 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Icon(
                  Icons.search,
                  size: 24.0,
                ),
              ),
            ),
            label: '',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
