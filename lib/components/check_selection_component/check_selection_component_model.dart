import '../../backend/api_requests/api_manager.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import 'check_selection_component.dart' show CheckSelectionComponent;
import 'package:flutter/material.dart';

class CheckSelectionComponentModel extends FlutterMadaModel<CheckSelectionComponent> {


  ApiCallResponse? leaveListApiCall;
  bool? isLoading = false;
  bool? mostSearched;
  bool? top;
  bool? recommended;

  List<dynamic> listOfLocalCategory = [];
  void addToListOfLocalCategory(dynamic item) =>
      listOfLocalCategory.add(item);
  void removeFromListOfLocalCategory(dynamic item) =>
      listOfLocalCategory.remove(item);
  void removeAtIndexFromListOfLocalCategory(int index) =>
      listOfLocalCategory.removeAt(index);
  void insertAtIndexInListOfLocalCategory(
      int index, dynamic item) =>
      listOfLocalCategory.insert(index, item);
  void updateListOfLocalCategoryAtIndex(
      int index, Function(dynamic) updateFn) =>
      listOfLocalCategory[index] = updateFn(listOfLocalCategory[index]);

  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
