// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/structure_main_flow/flutter_mada_util.dart';

class TokenModelStruct extends BaseStruct {
  TokenModelStruct({
    String? token,
    String? refreshToken,
  })  : _token = token,
        _refreshToken = refreshToken;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  // "refreshToken" field.
  String? _refreshToken;
  String get refreshToken => _refreshToken ?? '';
  set refreshToken(String? val) => _refreshToken = val;

  bool hasRefreshToken() => _refreshToken != null;

  static TokenModelStruct fromMap(Map<String, dynamic> data) =>
      TokenModelStruct(
        token: data['token'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  static TokenModelStruct? maybeFromMap(dynamic data) => data is Map
      ? TokenModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'token': _token,
        'refreshToken': _refreshToken,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'refreshToken': serializeParam(
          _refreshToken,
          ParamType.String,
        ),
      }.withoutNulls;

  static TokenModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      TokenModelStruct(
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        refreshToken: deserializeParam(
          data['refreshToken'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TokenModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TokenModelStruct &&
        token == other.token &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode => const ListEquality().hash([token, refreshToken]);
}

TokenModelStruct createTokenModelStruct({
  String? token,
  String? refreshToken,
}) =>
    TokenModelStruct(
      token: token,
      refreshToken: refreshToken,
    );
