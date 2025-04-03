import '../../app_state.dart';
import '../../general_exports.dart';
import '../../router/navigation_service.dart';

class HomePageModel extends ChangeNotifier {
  HomePageModel(this.onLogout) {
    getHomeScreenResult();
    getMasterData(onLogout: onLogout);
  }

  dynamic Function()? onLogout;
  dynamic homeData;
  List<String> homeBanner = <String>[];
  List<dynamic> mostPopularProjects = <dynamic>[];

  Future<void> getMasterData({void Function()? onLogout}) async {
    await ApiRequest(
      path: apiMasterData,
      className: 'SplashController/getMasterData',
      formatResponse: true,
    ).request(
        onSuccess: (dynamic data, dynamic response) {
          FFAppState().masterDateJsonModel = response[keyResults];
        },
        onLogout: onLogout);
  }

  void getHomeScreenResult() {
    startLoading();
    ApiRequest(
      path: apiHomeScreen,
      formatResponse: true,
      className: 'HomeController/getHomeScreenResult',
    ).request(onSuccess: (dynamic data, dynamic response) {
      dismissLoading();
      homeData = data;
      for (dynamic image in homeData[keyResults][keyHomeBanner]) {
        homeBanner.add(image[keyBannerImage]);
      }
      mostPopularProjects = homeData[keyResults][keyMostPopularProject];
      notifyListeners();
    } );
  }
}
