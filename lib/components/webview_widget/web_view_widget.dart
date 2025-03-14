import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import '../../general_exports.dart';

class MadaWebViewWidget extends StatelessWidget {
  const MadaWebViewWidget({required this.url, super.key});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebViewModel(),
      child: MadaWebView(
        url: url,
      ),
    );
  }
}

class MadaWebView extends StatefulWidget {
  const MadaWebView({required this.url, super.key});

  final String url;

  @override
  State<MadaWebView> createState() => _MadaWebViewState();
}

class _MadaWebViewState extends State<MadaWebView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WebViewModel>(context, listen: false)
          .initializeWebViewController(widget.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewModel>(
      builder: (context, provider, child) {
        return provider.isLoading
            ? const Center()
            : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: WebViewWidget(
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
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
    );
  }
}
