import '../../backend/api_requests/api_manager.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'create_360_component.dart' show Create360Component;
import 'package:flutter/material.dart';

class Create360ComponentModel extends FlutterMadaModel<Create360Component> {


  ApiCallResponse? getUserByIdCall;
 String? title;
 int? currentPageIndex = 0;

  FFUploadedFile uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
