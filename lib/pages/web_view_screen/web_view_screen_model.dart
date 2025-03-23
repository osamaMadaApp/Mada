import 'dart:io';

import '../../general_exports.dart';

class WebViewScreenModel extends ChangeNotifier {
  WebViewController? webViewController;

  void initialize(
    BuildContext context,
    String? urlPath,
    String? title,
    bool? isProjectBrouchure,
    String? brochureText, {
    bool isPDF = false,
    bool isBuy = false,
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
            onUrlChange: (UrlChange change) {
              if (isBuy == true) {
                if (change.url!.contains('failed')) {
                  Navigator.pop(context);
                  PaymentStatusDialog.show(
                    context: context,
                    title: FFLocalizations.of(context).getText(
                      'payment_status',
                    ),
                    message: FFLocalizations.of(context).getText(
                      'failed_payment_msg',
                    ),
                    status: FFLocalizations.of(context).getText(
                      'wrong',
                    ),
                    icon: iconWrong,
                    textColor: const Color(AppColors.red),
                  );
                } else if (change.url!.contains('success')) {
                  PaymentStatusDialog.show(
                    context: context,
                    title: FFLocalizations.of(context).getText(
                      'payment_status',
                    ),
                    message: FFLocalizations.of(context).getText(
                      'success_payment_msg',
                    ),
                    status: FFLocalizations.of(context).getText(
                      'success',
                    ),
                    icon: iconSuccess,
                    textColor: const Color(AppColors.primary),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.routeNavBar,
                    (Route<dynamic> route) => false,
                  );
                }
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(urlPath!));
    }

    notifyListeners();
  }
}
