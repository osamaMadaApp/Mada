import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../general_exports.dart';

void startLoading() {
  SmartDialog.showLoading(
    builder: (BuildContext context) => CircularProgressIndicator(
      backgroundColor: FlutterMadaTheme.of(context).primary.withOpacity(0.1),
      valueColor: AlwaysStoppedAnimation<Color>(
        FlutterMadaTheme.of(context).primary,
      ),
    ),
    clickMaskDismiss: true,
  );
}

void dismissLoading() {
  SmartDialog.dismiss();
}
