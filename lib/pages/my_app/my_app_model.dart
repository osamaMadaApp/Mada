import '../../app_state.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class AppProvider extends ChangeNotifier {
  AppProvider._();
  Locale? _locale;
  ThemeMode _themeMode = FlutterMadaTheme.themeMode;

  Locale? get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    await FlutterMadaTheme.initialize();

    final FFAppState appState = FFAppState();
    await appState.initializePersistedState();

    await getMasterData();
  }

  void setLocale(String language) {
    _locale = createLocale(language);

    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    FlutterMadaTheme.saveThemeMode(mode);
    notifyListeners();
  }

  static AppProvider? _instance;

  static AppProvider get instance => _instance ??= AppProvider._();

  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => showSplashImage;

  String getRedirectLocation() => _redirectLocation!;

  bool hasRedirect() => _redirectLocation != null;

  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;

  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }

  Future<void> getMasterData() async {
    await ApiRequest(
      path: apiMasterData,
      className: 'SplashController/getMasterData',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        FFAppState().masterDateJsonModel = response[keyResults];
      },
    );
  }
}
