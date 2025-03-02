// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/structure_main_flow/flutter_mada_util.dart';

class UserModelStruct extends BaseStruct {
  UserModelStruct({
    int? id,
    String? name,
    String? emailAddress,
    String? profilePhoto,
    String? phoneNumber,

    String? accessRole,
    String? auth,
  })  : _id = id,
        _name = name,
        _emailAddress = emailAddress,
        _profilePhoto = profilePhoto,
        _phoneNumber = phoneNumber,
        _accessRole = accessRole,
        _auth = auth;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "emailAddress" field.
  String? _emailAddress;
  String get emailAddress => _emailAddress ?? '';
  set emailAddress(String? val) => _emailAddress = val;

  bool hasEmailAddress() => _emailAddress != null;

  // "profilePhoto" field.
  String? _profilePhoto;
  String get profilePhoto => _profilePhoto ?? '';
  set profilePhoto(String? val) => _profilePhoto = val;

  bool hasProfilePhoto() => _profilePhoto != null;

  // "phoneNumber" field.
  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasphoneNumber() => _phoneNumber != null;


  // "AccessRole" field.
  String? _accessRole;
  String get accessRole => _accessRole ?? '';
  set accessRole(String? val) => _accessRole = val;


  bool hasAccessRole() => _accessRole != null;

  // "auth" field.
  String? _auth;
  String get auth => _auth ?? '';
  set auth(String? val) => _auth = val;


  bool hasauth() => _auth != null;


  static UserModelStruct fromMap(Map<String, dynamic> data) => UserModelStruct(
        id: data['id'] as int?,
        name: data['name'] as String?,
        emailAddress: data['emailAddress'] as String?,
        profilePhoto: data['profilePhoto'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
        accessRole: data['accessRole'] as String?,
        auth: data['auth'] as String?,
      );

  static UserModelStruct? maybeFromMap(dynamic data) => data is Map
      ? UserModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'emailAddress': _emailAddress,
        'profilePhoto': _profilePhoto,
        'phoneNumber': _phoneNumber,
        'accessRole': _accessRole,
        'auth': _auth,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'emailAddress': serializeParam(
          _emailAddress,
          ParamType.String,
        ),
        'profilePhoto': serializeParam(
          _profilePhoto,
          ParamType.String,
        ),
        'phoneNumber': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),

        'accessRole': serializeParam(
          _accessRole,
          ParamType.String,
        ),
        'auth': serializeParam(
          _auth,
          ParamType.String,
        ),

      }.withoutNulls;

  static UserModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserModelStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        emailAddress: deserializeParam(
          data['emailAddress'],
          ParamType.String,
          false,
        ),
        profilePhoto: deserializeParam(
          data['profilePhoto'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phoneNumber'],
          ParamType.String,
          false,
        ),

        accessRole: deserializeParam(
          data['accessRole'],
          ParamType.String,
          false,
        ),
        auth: deserializeParam(
          data['auth'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserModelStruct &&
        id == other.id &&
        name == other.name &&
        emailAddress == other.emailAddress &&
        profilePhoto == other.profilePhoto &&
        phoneNumber == other.phoneNumber &&
        accessRole == other.accessRole &&
        auth == other.auth ;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        emailAddress,
        profilePhoto,
        phoneNumber,
        accessRole,
    auth,
      ]);

  UserModelStruct copyWith({
    int? id,
    String? name,
    String? emailAddress,
    String? phoneNumber,
    String? accessRole,
    String? auth,
  }) {
    return UserModelStruct(
      id: id ?? this.id,
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessRole: accessRole ?? this.accessRole,
      auth: auth ?? this.auth,
    );
  }
}

UserModelStruct createUserModelStruct({
  int? id,
  String? name,
  String? emailAddress,
  String? profilePhoto,
  String? phoneNumber,
  String? accessRole,
  String? auth,
}) =>
    UserModelStruct(
      id: id,
      name: name,
      emailAddress: emailAddress,
      profilePhoto: profilePhoto,
      phoneNumber: phoneNumber,
      accessRole: accessRole,
      auth: auth
    );
