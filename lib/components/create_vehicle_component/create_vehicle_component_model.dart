import '../../backend/api_requests/api_manager.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'create_vehicle_component.dart' show CreateVehicleComponent;
import 'package:flutter/material.dart';

class CreateVehicleComponentModel extends FlutterMadaModel<CreateVehicleComponent> {


  ApiCallResponse? getUserByIdCall;
 String? title;
 int? currentPageIndex = 0;

  FFUploadedFile uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile2 = FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile3 = FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile4 = FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile5 = FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile6 = FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
