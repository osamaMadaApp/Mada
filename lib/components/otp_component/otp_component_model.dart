import 'package:pinput/pinput.dart';

import '../../general_exports.dart';

class OtpComponentModel extends ChangeNotifier {
  //

  bool? isValid;

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    consoleLog(currentIndex);
    notifyListeners();
  }

  PinTheme themePin(BuildContext context) {
    return PinTheme(
      height: 76.h,
      width: 352.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: FlutterMadaTheme.of(context).color989898,
        ),
      ),
    );
  }
}
