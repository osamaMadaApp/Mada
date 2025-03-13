import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';
import '../../structure_main_flow/nav/nav.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1366),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return Consumer<AppProvider>(
          builder: (context, appProvider, child) {
            return MaterialApp.router(
              title: 'Mada',
              builder: FlutterSmartDialog.init(),
              localizationsDelegates: const <LocalizationsDelegate>[
                FFLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: appProvider.locale,
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
              themeMode: appProvider.themeMode,
              routerConfig: createRouter(AppProvider.instance),
            );
          },
        );
      },
    );
  }
}
