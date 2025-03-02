import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/schema/structs/index.dart';
import 'backend/schema/structs/token_model_struct.dart';
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
      if (prefs.containsKey('ff_TokenModel')) {
        try {
          final serializedData = prefs.getString('ff_TokenModel') ?? '{}';
          _TokenModel =
              TokenModelStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_UserModelWithJson')) {
        try {
          final serializedData =
              prefs.getString('ff_UserModelWithJson') ?? '{}';
          _UserModelWithJson = jsonDecode(serializedData);
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_UserModelAppState')) {
        try {
          final serializedData =
              prefs.getString('ff_UserModelAppState') ?? '{}';
          _UserModelAppState =
              UserModelStruct.fromSerializableMap(jsonDecode(serializedData));
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
      _allowCookies = prefs.getBool('ff_allowCookies') ?? _allowCookies;
    });
    _safeInit(() {
      _isGust = prefs.getBool('ff_isGust') ?? _isGust;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_UserModel')) {
        try {
          final serializedData = prefs.getString('ff_UserModel') ?? '{}';
          _UserModel =
              UserModelStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
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


  Map<String, dynamic> _UserModelWithJson =  {};
  Map<String, dynamic> get UserModelWithJsonState => _UserModelWithJson;
  set UserModelWithJsonState(Map<String, dynamic> value) {
    _UserModelWithJson = value;
    prefs.setString('ff_UserModelWithJson', value.toString());
  }

  // void updateUserModelWithJson(Function(UserModelWithJson) updateFn) {
  //   updateFn(_UserModelWithJson);
  //   prefs.setString('ff_UserModelWithJson', _UserModelWithJson);
  // }
  bool _allowCookies = false;
  bool _isGust = false;

  int _selectedLangugeAppState = 1;

  int get selectedLangugeAppState => _selectedLangugeAppState;

  set selectedLangugeAppState(int value) {
    _selectedLangugeAppState = value;
    prefs.setInt('ff_selectedLangugeAppState', value);
  }

  String getSelectedLanguge() {
    return _selectedLangugeAppState == 1 ? 'en' : 'ar';
  }

  TokenModelStruct _TokenModel = TokenModelStruct();
  TokenModelStruct get TokenModel => _TokenModel;
  set TokenModel(TokenModelStruct value) {
    _TokenModel = value;
    prefs.setString('ff_TokenModel', value.serialize());
  }

  void updateTokenModelStruct(Function(TokenModelStruct) updateFn) {
    updateFn(_TokenModel);
    prefs.setString('ff_TokenModel', _TokenModel.serialize());
  }

  bool get allowCookies => _allowCookies;
  set allowCookies(bool value) {
    _allowCookies = value;
    prefs.setBool('ff_allowCookies', value);
  }
  bool get  isGust => _isGust;
  set  isGust(bool value) {
    _isGust = value;
    prefs.setBool('ff_isGust', value);
  }

  void updateAllowCookies(Function(bool) updateFn) {
    updateFn(_isGust);
    prefs.setBool('ff_isGust', _isGust);
  }

  UserModelStruct _UserModel = UserModelStruct();
  UserModelStruct get UserModel => _UserModel;
  set UserModel(UserModelStruct value) {
    _UserModel = value;
    prefs.setString('ff_UserModel', value.serialize());
  }


  UserModelStruct _UserModelAppState = UserModelStruct();

  UserModelStruct get UserModelAppState => _UserModelAppState;

  set UserModelAppState(UserModelStruct value) {
    _UserModelAppState = value;
    prefs.setString('ff_UserModelAppState', value.serialize());
  }

  void updateUserModelAppStateStruct(Function(UserModelStruct) updateFn) {
    updateFn(_UserModelAppState);
    prefs.setString('ff_UserModelAppState', _UserModelAppState.serialize());
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
