import '../../general_exports.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider(
      create: (context) => PdfViewModel(
        urlPath: args?[keyUrl] ?? '',
        title: args?[keyTitle] ?? '',
      ),
      child: Consumer<PdfViewModel>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: MadaHeader(
              title: controller.title,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.download_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.downloadPdf(
                      FFLocalizations.of(context).getText('success_download'),
                    );
                  },
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                const PDF().cachedFromUrl(
                  controller.urlPath,
                  placeholder: (double progress) => Center(
                    child: CircularProgressIndicator(value: progress),
                  ),
                  errorWidget: (error) => Center(
                    child: Text('Error loading PDF: $error'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
