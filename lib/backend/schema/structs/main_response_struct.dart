// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/structure_main_flow/flutter_mada_util.dart';

class MainResponseStruct extends BaseStruct {
  MainResponseStruct({
    bool? succeeded,
    Map<String, dynamic>? data,
    List<String>? message,
    int? code,
  })  : _succeeded = succeeded,
        _data = data,
        _message = message,
        _code = code;

  // "succeeded" field.
  bool? _succeeded;
  bool get succeeded => _succeeded ?? false;
  set succeeded(bool? val) => _succeeded = val;

  bool hasSucceeded() => _succeeded != null;

  // "data" field.
  Map<String, dynamic>? _data;
  Map<String, dynamic>? get data => _data;
  set data(Map<String, dynamic>? val) => _data = val;

  bool hasData() => _data != {};

  // "message" field.
  List<String>? _message;
  List<String> get message => _message ?? const [];
  set message(List<String>? val) => _message = val;

  void updateMessage(Function(List<String>) updateFn) {
    updateFn(_message ??= []);
  }

  bool hasMessage() => _message != null;

  // "code" field.
  int? _code;
  int get code => _code ?? 0;
  set code(int? val) => _code = val;

  void incrementCode(int amount) => code = code + amount;

  bool hasCode() => _code != null;

  static MainResponseStruct fromMap(Map<String, dynamic> data) =>
      MainResponseStruct(
        succeeded: data['succeeded'] as bool?,
        data: data['data'] as Map<String, dynamic>?,
        message: getDataList(data['message']),
        code: castToType<int>(data['code']),
      );

  static MainResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? MainResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'succeeded': _succeeded,
        'data': _data,
        'message': _message,
        'code': _code,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'succeeded': serializeParam(
          _succeeded,
          ParamType.bool,
        ),
        'data': serializeParam(
          _data,
          ParamType.JSON,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
          isList: true,
        ),
        'code': serializeParam(
          _code,
          ParamType.int,
        ),
      }.withoutNulls;

  static MainResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      MainResponseStruct(
        succeeded: deserializeParam(
          data['succeeded'],
          ParamType.bool,
          false,
        ),
        data: deserializeParam(
          data['data'],
          ParamType.JSON,
          false,
        ),
        message: deserializeParam<String>(
          data['message'],
          ParamType.String,
          true,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'MainResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MainResponseStruct &&
        succeeded == other.succeeded &&
        data == other.data &&
        listEquality.equals(message, other.message) &&
        code == other.code;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([succeeded, data, message, code]);
}

MainResponseStruct createMainResponseStruct({
  bool? succeeded,
  Map<String, dynamic>? data,
  int? code,
}) =>
    MainResponseStruct(
      succeeded: succeeded,
      data: data,
      code: code,
    );
