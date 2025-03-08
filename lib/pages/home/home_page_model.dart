import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page_widget.dart' show HomePage;

class HomePageModel extends FlutterMadaModel<HomePage> {
  dynamic homeData;
  List<String> homeBanner = <String>[];
  List<dynamic> mostPopularProjects = <dynamic>[];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
