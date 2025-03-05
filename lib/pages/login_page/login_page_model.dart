import '../../components/login_side_component/login_side_component_model.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterMadaModel<LoginPageWidget> {

  late LoginSideComponentModel  loginSideComponentModel;


  @override
  void initState(BuildContext context) {
    loginSideComponentModel =
        createModel(context, () => LoginSideComponentModel());
  }

  @override
  void dispose() {
    loginSideComponentModel.dispose();
  }
}
