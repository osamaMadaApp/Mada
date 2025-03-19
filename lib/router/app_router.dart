import '../general_exports.dart';
import '../pages/exclusive_projects/exclusive_projects.dart';
import '../pages/login_page/login_page_widget.dart';
import '../pages/projects_listview/projects_listview.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.routeSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.routeNavBar:
        return MaterialPageRoute(
          builder: (_) => const NavBarPage(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeHome:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginPageWidget(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeExclusiveProjects:
        return MaterialPageRoute(
          builder: (_) => const ExclusiveProjects(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routePdfScreen:
        return MaterialPageRoute(
          builder: (_) => const PDFScreen(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeProjectsListview:
        return MaterialPageRoute(
          builder: (_) => ProjectsListview(
            keyTitle: args?[keyTitle],
            keyProjectStatus: args?[keyProjectStatus],
            keyType: args?[keyType],
          ),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeSearchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routePropertyDetails:
        return MaterialPageRoute(
          builder: (_) => const PropertyDetailsScreen(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeVideoPlayer:
        return MaterialPageRoute(
          builder: (_) => const VideoScreen(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.routeWebViewScreen:
        return MaterialPageRoute(
          builder: (_) => const WebViewScreen(),
          settings: RouteSettings(arguments: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
