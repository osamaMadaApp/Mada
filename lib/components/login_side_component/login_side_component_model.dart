import '../../backend/api_requests/api_manager.dart';
import 'package:flutter/material.dart';

class LoginSideComponentModel extends   ChangeNotifier{
  ApiCallResponse? leaveListApiCall;

  //
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textControllerValidator1;
  bool? textController1State;

  //
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textControllerValidator2;
  bool? textController2State;
  late bool passwordVisibility;
  bool? isValidEmail ;

  void initState() {
    textController1 ??= TextEditingController();
    textFieldFocusNode1 ??= FocusNode();
    //
    textController2 ??= TextEditingController();
    textFieldFocusNode2 ??= FocusNode();
    passwordVisibility = false;
  }


  void dispose() {
  }

  bool buttonEnabled() {
    return (textController1?.text.isNotEmpty == true) &&
        (textController2?.text.isNotEmpty == true);
  }
  bool emailValid(String? value) {
    return isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+").hasMatch(value ?? '');
  }
}
