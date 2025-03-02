import '../../backend/api_requests/api_manager.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterMadaModel<LoginPageWidget> {

  bool isSignIn = true;
  ApiCallResponse? loginCall;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
