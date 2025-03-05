import '../../backend/api_requests/api_manager.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'login_side_component.dart' show LoginSideComponent;
import 'package:flutter/material.dart';

class LoginSideComponentModel extends FlutterMadaModel<LoginSideComponent> {


  ApiCallResponse? leaveListApiCall;

  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
