import '../../app_state.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';

class AppProvider extends ChangeNotifier {
  AppProvider._();
  Locale? _locale;
  ThemeMode _themeMode = FlutterMadaTheme.themeMode;

  Locale? get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  Future<void> init({void Function()? onLogout}) async {
    await FlutterMadaTheme.initialize();

    final FFAppState appState = FFAppState();
    await appState.initializePersistedState();

    await getMasterData( onLogout : onLogout);

    // await refreshToken();
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

  Future<void> getMasterData({void Function()? onLogout}) async {
    await ApiRequest(
      path: apiMasterData,
      className: 'SplashController/getMasterData',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        FFAppState().masterDateJsonModel = response[keyResults];
      },
      onLogout: onLogout
    );
  }
  Future<void> getMasterDataProfile() async {
    await ApiRequest(
      path: apiMasterData,
      className: 'SplashController/getMasterData',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        FFAppState().masterDateJsonModel = response[keyResults];
      }
    );
  }

  void onNafathVerificationPress(BuildContext context) {
    if (FFAppState().userModel[keyIsNafathVerified] == 1) {
      showToast(FFLocalizations.of(context).getText('nafath_already_verified'));
      return;
    }
    startLoading();
    ApiRequest(
      path: apiNafathRequest,
      method: ApiMethods.post,
      className: 'ViewProfileController/onNafathVerificationPress',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (response[keySuccess] == true) {
          showToast(
              FFLocalizations.of(context).getText('please_confirm_nafath'));
          SideSheet.show(
            context,
            child: NafathNumberSheet(
              nafathNumber: data[keyResults][keyNafathCode],
            ),
            title: FFLocalizations.of(context).getText('nafath_number'),
          );
        } else {
          showToast(response[keyMsg]);
        }
      },
    );
  }

  // Future<void> refreshToken() async {
  //   if (FFAppState().userModel.isEmpty) {
  //     return;
  //   }
  //   final Map<String, dynamic> deviceInfoDetails = await getDeviceInfo();
  //
  //   ApiRequest(
  //     path: apiRefreshToken,
  //     method: ApiMethods.post,
  //     withAuth: false,
  //     className: 'AppProvider/refreshToken',
  //     defaultHeadersValue: false,
  //     body: <String, dynamic>{
  //       keyRefreshToken: FFAppState().userModel[keyRefreshToken],
  //       ...deviceInfoDetails,
  //     },
  //   ).request(
  //     onSuccessWithHeader: (dynamic data, dynamic response, dynamic headers) {
  //       notifyListeners();
  //       if (response[keySuccess] == true) {
  //         FFAppState().userModel[keyToken] = data[keyResults][keyToken];
  //         FFAppState().userModel[keyRefreshToken] =
  //             data[keyResults][keyRefreshToken];
  //         consoleLog(FFAppState().userModel[keyToken], key: 'new_token');
  //       }
  //     }
  //   );
  // }
}
