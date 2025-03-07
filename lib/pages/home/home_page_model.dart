 import 'package:Mada/backend/api_requests/api_calls.dart';

import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page.dart' show HomePage;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterMadaModel<HomePage> {

  ApiCallResponse? getDataCall;


  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
