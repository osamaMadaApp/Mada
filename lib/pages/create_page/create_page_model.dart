import 'dart:collection';

import '../../backend/api_requests/api_manager.dart';
import '../../components/create_vehicle_component/create_vehicle_component_model.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'create_page.dart' show CreatePage;
import 'package:flutter/material.dart';

class CreatePageModel extends FlutterMadaModel<CreatePage> {
  ApiCallResponse? getUserByIdCall;
  String? title;
  int? currentPageIndex = 0;
  HashMap<int, int>? selectedSpic = HashMap<int, int>();
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile5 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile6 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  FFUploadedFile uploadedLocalFile360 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  dynamic selectedBrand;
  dynamic selectedModel;
  dynamic selectedCategory;
  dynamic selectedSpecification;
  bool? isBottom;
  bool? mostSearched;
  bool? top;
  bool? recommended;
  ApiCallResponse? create;
  ApiCallResponse? uploadMainImageIdApiCall;
  ApiCallResponse? uploadSecImageIdApiCall;
  ApiCallResponse? uploadMedia;
  late CreateVehicleComponentModel modelCreateVehicleComponentModel;


  @override
  void initState(BuildContext context) {
    modelCreateVehicleComponentModel =
        createModel(context, () => CreateVehicleComponentModel());
  }

  @override
  void dispose() {
    modelCreateVehicleComponentModel.dispose();
  }
}
