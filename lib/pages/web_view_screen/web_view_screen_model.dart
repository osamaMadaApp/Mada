import 'dart:io';

import '../../general_exports.dart';

class WebViewScreenModel extends ChangeNotifier {
  WebViewController? webViewController;

  void initialize(
    String? urlPath,
    String? title,
    bool? isProjectBrouchure,
    String? brochureText, {
    bool isPDF = false,
  }) {
    consoleLog(urlPath, key: 'urlPath');

    if (!isPDF || Platform.isIOS) {
      startLoading();
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              dismissLoading();
            },
            onUrlChange: (UrlChange change) {},
          ),
        )
        ..loadRequest(Uri.parse(urlPath!));
    }

    notifyListeners();
  }
}
