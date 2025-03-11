import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import 'otp_component.dart' show OtpComponent;

class OtpComponentModel   extends ChangeNotifier{
  //

 bool? isValid;



  @override
  void dispose() {
    super.dispose();


  }
 void changeTab(int index) {

   notifyListeners();
 }

  PinTheme themePin(BuildContext context){
    return PinTheme(
      height: 76.h,
      width: 352.w,
      decoration: BoxDecoration(
        color:   Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: FlutterMadaTheme.of(context).color989898,
        ),
      ),
    );
  }


}
