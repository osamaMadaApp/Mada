import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import '../../general_exports.dart';

class AqarekWebviewWidget extends StatelessWidget {
  const AqarekWebviewWidget({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebViewModel(url),
      child: Consumer<WebViewModel>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: WebViewWidget(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory(() => EagerGestureRecognizer()),
                    },
                    controller: provider.webViewController,
                  ),
                ),
                if (provider.isLoading) const Center(),
              ],
            ),
          );
        },
      ),
    );
  }
}
