import '../../app_state.dart';
import '../../general_exports.dart';

class TermsAndCOnditions extends StatelessWidget {
  const TermsAndCOnditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          MadaWebViewWidget(
            url: FFAppState().masterDateJsonModel[keyTermsAndConditions],
          ),
        ],
      ),
    );
  }
}
