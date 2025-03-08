import '../../general_exports.dart';

class MenuPageModel extends ChangeNotifier implements TickerProvider {
  MenuPageModel() {
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    tabController.addListener(() {
      notifyListeners();
    });
  }

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
