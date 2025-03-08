import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page.dart' show HomePage;

class HomePageModel extends FlutterMadaModel<HomePage> {
  @override
  void initState(BuildContext context) {
    ApiRequest(
      path: apiHomeScreen,
      formatResponse: true,
      className: 'HomeController/getHomeScreenResult',
    ).request(
      onSuccess: (dynamic data, dynamic response) {

      },
    );
  }

  @override
  void dispose() {}
}
