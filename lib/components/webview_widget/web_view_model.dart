import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/index.dart';

class WebViewModel extends ChangeNotifier {
  late WebViewController webViewController;
  bool isLoading = true;

  void initializeWebViewController(String url) {
    startLoading();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading = true;
            notifyListeners();
          },
          onPageFinished: (String url) {
            isLoading = false;
            dismissLoading();
            notifyListeners();
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  void dispose() {
    webViewController.clearCache();
    super.dispose();
  }
}
