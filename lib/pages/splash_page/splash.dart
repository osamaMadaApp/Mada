import '../../app_state.dart';
import '../../general_exports.dart';
import '../../services/push_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<AppProvider>(context, listen: false)
          .setLocale(FFAppState().getSelectedLanguge());
    });
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 4));
    final bool isLoggedIn = FFAppState().isLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.routeNavBar);
      } else {
        Navigator.pushReplacementNamed(context, Routes.routeLogin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PushNotificationService().setupInteractedMessage(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageGrayLogo, width: 100),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
