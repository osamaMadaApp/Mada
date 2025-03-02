import '../../backend/api_requests/api_manager.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'details_page.dart' show DetailsPage;
import 'package:flutter/material.dart';

class DetailsPageModel extends FlutterMadaModel<DetailsPage> {


  ApiCallResponse? getUserByIdCall;


  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
