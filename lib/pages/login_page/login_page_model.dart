import '../../components/forget_password_component/forget_password_component.dart';
import '../../components/forget_password_component/forget_password_component_model.dart';
import '../../components/login_side_component/login_side_component_model.dart';
import '../../components/otp_component/otp_component_model.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterMadaModel<LoginPageWidget> {
  late LoginSideComponentModel loginSideComponentModel;
  late ForgetPasswordComponentModel forgetPasswordComponent;
  late OtpComponentModel otpComponent;
  String? currentModelName;

  @override
  void initState(BuildContext context) {
    loginSideComponentModel = createModel(context, () => LoginSideComponentModel());
    forgetPasswordComponent = createModel(context, () => ForgetPasswordComponentModel());
    otpComponent = createModel(context, () => OtpComponentModel());
    currentModelName = 'LoginSideComponent';
  }

  @override
  void dispose() {
    loginSideComponentModel.dispose();
  }
}
