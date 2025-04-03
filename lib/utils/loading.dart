import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../app_state.dart';
import '../general_exports.dart';

void startLoading({BuildContext? cContext}) {
  SmartDialog.showLoading(
    builder: (BuildContext context) => CircularProgressIndicator(
      backgroundColor:
          FlutterMadaTheme.of(cContext ?? context).primary.withOpacity(0.1),
      valueColor: AlwaysStoppedAnimation<Color>(
        FlutterMadaTheme.of(cContext ?? context).primary,
      ),
    ),
    clickMaskDismiss: true,
  );
}


void dismissLoading() {
  SmartDialog.dismiss();
}
