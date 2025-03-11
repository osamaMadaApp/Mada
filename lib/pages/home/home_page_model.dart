import '../../general_exports.dart';

class HomePageModel extends ChangeNotifier {
  HomePageModel() {
    getHomeScreenResult();
  }

  dynamic homeData;
  List<String> homeBanner = <String>[];
  List<dynamic> mostPopularProjects = <dynamic>[];

  void getHomeScreenResult() {
    startLoading();
    ApiRequest(
      path: apiHomeScreen,
      formatResponse: true,
      className: 'HomeController/getHomeScreenResult',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        homeData = data;
        for (dynamic image in homeData[keyResults][keyHomeBanner]) {
          homeBanner.add(image[keyBannerImage]);
        }
        mostPopularProjects = homeData[keyResults][keyMostPopularProject];
        notifyListeners();
      },
    );
  }
}
