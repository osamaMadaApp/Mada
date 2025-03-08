import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'forget_password_component.dart' show ForgetPasswordComponent;

class ForgetPasswordComponentModel extends FlutterMadaModel<ForgetPasswordComponent> {
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textControllerValidator1;
  bool? textController1State;


  bool? isValidEmail ;

  @override
  void initState(BuildContext context) {
    textController1 ??= TextEditingController();
    textFieldFocusNode1 ??= FocusNode();
    //

  }

  @override
  void dispose() {

    //
  }

  bool buttonEnabled() {
    return (textController1?.text.isNotEmpty == true);
  }
  bool emailValid(String? value) {
    return isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+").hasMatch(value ?? '');
  }
}
