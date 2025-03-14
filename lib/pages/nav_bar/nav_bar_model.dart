import '../../general_exports.dart';

class NavBarModel extends ChangeNotifier {
  NavBarModel() {
    consoleLog(currentIndex, key: 'current_index');
  }
  String _currentPageName = 'HomePage';
  int _currentIndex = 0;

  final Map<String, Widget> tabs = {
    'HomePage': const HomePage(),
    'MyOrderPage': const MyOrderPage(),
    'NotificationsPage': const NotificationsPage(),
    'MenuPage': const MenuPage(),
  };

  String get currentPageName => _currentPageName;
  int get currentIndex => _currentIndex;
  Widget get currentPage => tabs[_currentPageName] ?? const HomePage();

  void changePage(int index) {
    _currentIndex = index;
    _currentPageName = tabs.keys.toList()[index];
    notifyListeners();
  }

  Widget getCurrentPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const MyOrderPage();
      case 2:
        return const NotificationsPage();
      case 3:
        return const MenuPage();
      default:
        return const Center();
    }
  }
}
