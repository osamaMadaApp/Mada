import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class MenuPageModel extends ChangeNotifier implements TickerProvider {
  MenuPageModel() {
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    tabController.addListener(() {
      notifyListeners();
    });

    sliderSettings = FFAppState().masterDateJsonModel[keySliderSettings] ?? [];
    awards = FFAppState().masterDateJsonModel[keyAwardSettings] ?? [];
    bannerImages = awards.map((item) => item['bannerImage'] as String).toList();
  }

  List<dynamic> sliderSettings = [];
  List<dynamic> awards = [];
  List<String> bannerImages = [];

  late TabController tabController;

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  void changeTab(int index) {
    tabController.animateTo(index);
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }
}
