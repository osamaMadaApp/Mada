import 'dart:io';

import '../../general_exports.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<WebViewScreenModel>(
      create: (BuildContext context) => WebViewScreenModel(),
      child: WebViewComponent(
        urlPath: args?[keyUrl],
        title: args?[keyTitle],
        brochureText: args?[keySubtitle],
        isProjectBrouchure: args?[keyProjectBrouchure],
        isPDF: args?[keyIsPdf] ?? false,
      ),
    );
  }
}

class WebViewComponent extends StatefulWidget {
  const WebViewComponent({
    super.key,
    this.urlPath,
    this.title,
    this.isProjectBrouchure,
    this.brochureText,
    this.isPDF = false,
  });

  final String? urlPath;
  final String? title;
  final bool? isProjectBrouchure;
  final String? brochureText;
  final bool isPDF;

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<WebViewScreenModel>(context, listen: false).initialize(
        context,
        widget.urlPath,
        widget.title,
        widget.isProjectBrouchure,
        widget.brochureText,
        isPDF: widget.isPDF,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewScreenModel>(
      builder: (
        BuildContext context,
        WebViewScreenModel model,
        Widget? child,
      ) {
        return PopScope(
          onPopInvokedWithResult: (bool value, dynamic data) {
            dismissLoading();
          },
          child: Scaffold(
              backgroundColor: const Color(AppColors.gray3),
              appBar: MadaHeader(
                title: widget.title,
                actions: [
                  if (widget.isProjectBrouchure != null &&
                      widget.isProjectBrouchure!)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DEVICE_WIDTH * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Share.share(widget.urlPath ?? '');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(AppColors.gray4)
                                .withValues(alpha: 0.25),
                            borderRadius:
                                BorderRadius.circular(DEVICE_HEIGHT * 0.008),
                          ),
                          child: SvgPicture.asset(
                            iconGreenShare,
                            height: 78.h,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isProjectBrouchure != null &&
                      widget.isProjectBrouchure!)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DEVICE_WIDTH * 0.04,
                        vertical: DEVICE_WIDTH * 0.02,
                      ),
                      child: Text(
                        widget.brochureText ??
                            FFLocalizations.of(context)
                                .getText('project_brochure'),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(AppColors.black),
                            ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widget.isProjectBrouchure != null &&
                                widget.isProjectBrouchure!
                            ? DEVICE_WIDTH * 0.04
                            : 0,
                        right: widget.isProjectBrouchure != null &&
                                widget.isProjectBrouchure!
                            ? DEVICE_WIDTH * 0.04
                            : 0,
                        bottom: widget.isProjectBrouchure != null &&
                                widget.isProjectBrouchure!
                            ? DEVICE_WIDTH * 0.05
                            : 0,
                      ),
                      child: widget.isPDF && Platform.isAndroid
                          ? const PDF(
                              autoSpacing: false,
                              pageFling: false,
                            ).cachedFromUrl(widget.urlPath ?? '')
                          : model.webViewController != null
                              ? WebViewWidget(
                                  controller: model.webViewController!,
                                )
                              : const Center(),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
