import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'structure_main_flow/flutter_mada_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();


  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_UserModelWithJson')) {
        try {
          final String? serializedData =
              prefs.getString('ff_UserModelWithJson') ?? '{}';
         _UserJsonModel = jsonDecode(serializedData ?? '');
         print('');
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _selectedLangugeAppState = prefs.getInt('ff_selectedLangugeAppState') ??
          _selectedLangugeAppState;
    });
    _safeInit(() {
      _timerTimeStamp = prefs.getInt('ff_timerTime') ??
          _timerTimeStamp;
    });
  }

  static void reset() {
    _instance = FFAppState._internal();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool isLoggedIn(){
    return  _UserJsonModel['_id']!=null;
  }


  Map<String, dynamic> _UserJsonModel =  {};
  Map<String, dynamic> get userModel => _UserJsonModel;
  set userModel(Map<String, dynamic> value) {
    _UserJsonModel = value;
    prefs.setString('ff_UserModelWithJson', jsonEncode(value) );
  }

  int _selectedLangugeAppState = 1;
  int get selectedLangugeAppState => _selectedLangugeAppState;

  set selectedLangugeAppState(int value) {
    _selectedLangugeAppState = value;
    prefs.setInt('ff_selectedLangugeAppState', value);
  }

  String getSelectedLanguge() {
    return _selectedLangugeAppState == 1 ? 'en' : 'ar';
  }

  int _timerTimeStamp = 0;
  int get timerTimeStamp => _timerTimeStamp;
  set timerTimeStamp(int value) {
    _timerTimeStamp = value;
    prefs.setInt('ff_timerTime', value);
  }

}



void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
