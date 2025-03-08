import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page.dart' show HomePage;

class HomePageModel extends FlutterMadaModel<HomePage> {
  dynamic homeData;
  List<String> homeBanner = <String>[];
  List<dynamic> mostPopularProjects = <dynamic>[];

  @override
  void initState(BuildContext context) {
    ApiRequest(
      path: apiHomeScreen,
      formatResponse: true,
      className: 'HomeController/getHomeScreenResult',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        homeData = data;
        for (dynamic image in homeData[keyResults][keyHomeBanner]) {
          homeBanner.add(image[keyBannerImage]);
        }
        mostPopularProjects = homeData[keyResults][keyMostPopularProject];
      },
    );
  }

  @override
  void dispose() {}
}
