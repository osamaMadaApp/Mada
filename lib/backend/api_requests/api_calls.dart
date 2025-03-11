import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../api/api_routes.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'api_manager.dart';
import 'interceptors.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start BlockToBookApiGroup Group Code

class MadaApiGroupGroup {
  // static String getBaseUrl() => 'http://localhost:8080';

  static String getBaseUrl() => 'https://mycar.completechaintech.com';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
  static LoginAnonymouslyUserCall loginAnonymouslyUser =
      LoginAnonymouslyUserCall();
  static GetUserByIdCall getUserByIdCall = GetUserByIdCall();
  static GetSliderCall getSliderCall = GetSliderCall();
  static GetCarsCall getCarsCall = GetCarsCall();
  static GetFavList getFavList = GetFavList();
  static AddFavList addFavList = AddFavList();
  static RemoveFavList removeFavList = RemoveFavList();
  static POSTEVENTCall POSTeventCall = POSTEVENTCall();
  static CreateInvolvingCall createInvolvingCall = CreateInvolvingCall();
  static CreateGiftCall createGiftCall = CreateGiftCall();
  static CreateShilfCall createShilfCall = CreateShilfCall();
  static CreateimageCallWeb createimageCallWeb = CreateimageCallWeb();
  static GetAllInvolvingCall getAllInvolvingCall = GetAllInvolvingCall();
  static GetAllEventTypsCall getAllEventTypsCall = GetAllEventTypsCall();
  static MultiListCall multiListCall = MultiListCall();
  static CreateVehicleCall createVehicleCall = CreateVehicleCall();
  static RefreshApiCall refreshApiCall = RefreshApiCall();
  static UploadMainImageIdApiCall uploadMainImageIdApiCall =
      UploadMainImageIdApiCall();
  static UploadSecImageIdApiCall uploadSecImageIdApiCall =
      UploadSecImageIdApiCall();
  static UploadMedia uploadMedia = UploadMedia();
  static final interceptors = [
    ExampleInterceptor(),
  ];
}

class POSTEVENTCall {
  Future<ApiCallResponse> call({
    String? authorization = '',
    int? eventType,
    String? titleEn,
    String? titleAr,
    String? subTitleAr,
    String? subTitleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? mainImage,
    String? fromDate,
    String? toDate,
    String? fromTime,
    String? toTime,
    bool? isVisible = true,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "eventType": $eventType,
  "titleEn": "$titleEn",
  "titleAr": "$titleAr",
  "subTitleAr": "$subTitleAr",
  "subTitleEn": "$subTitleEn",
  "descriptionAr": "$descriptionAr",
  "descriptionEn": "$descriptionEn",
  "mainImage": "$mainImage",
  "fromDate": "$fromDate",
  "toDate": "$toDate",
  "fromTime": "$fromTime",
  "toTime": "$toTime",
  "isVisible": $isVisible
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'POSTEVENTCall',
        apiUrl: '$baseUrl/Api/Involving/POSTEVENT',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authorization',
          "Content-Type": "text/plain"
        },
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class RefreshApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? refreshToken = '',
    int? languageId = 1,
    String? path
  }) async {
    final ffApiRequestBody = '''
{
  "token": "$token" ,
  "refresh_token": "$refreshToken"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GoogleLoginApi',
        apiUrl: path ?? '',
        callType: ApiCallType.POST,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}


class CreateInvolvingCall {
  Future<ApiCallResponse> call(
      {String? authorization = '',
      String? firstName = '',
      String? lastName = '',
      String? email = '',
      String? phoneNumber = '',
      String? involvingType = '',
      String? latitude,
      String? longitude}) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "firstName": "$firstName",
  "lastName": "$lastName",
  "email": "$email",
  "phoneNumber": "$phoneNumber",
  "involvingType": "$involvingType",
  "latitude": "$latitude",
  "longitude": "$longitude"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CreateInvolvingCall',
        apiUrl: '$baseUrl/Api/Involving/POST',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authorization',
          "Content-Type": "text/plain"
        },
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class CreateGiftCall {
  Future<ApiCallResponse> call({
    required String authorization,
    String? bookTitle,
    String? prefTopic,
    String? address,
    String? surName,
    bool? hospitalPatient,
    bool? childInNeed,
    bool? seniorInCarHome,
    bool? localShelter,
    bool? anInmate,
    bool? aLibrary,
    bool? aCaseOfCharity,
    bool? aSchoolInSeniorCenter,
    bool? aFriendInNeed,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
 "bookTitle": "$bookTitle",
      "prefTopic": "$prefTopic",
      "address": "$address",
      "surName": "$surName",
      "hospitalPationt": $hospitalPatient,
      "childInNeed": $childInNeed,
      "seniorInCarHome": $seniorInCarHome,
      "localShulter": $localShelter,
      "anInimat": $anInmate,
      "aLibrary": $aLibrary,
      "aCaseOfSharity": $aCaseOfCharity,
      "aScoolInSiniorCenter": $aSchoolInSeniorCenter,
      "aFrindInNeed": $aFriendInNeed
}''';

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CreateGiftsCall',
        apiUrl: '$baseUrl/Api/Gifts/POST',
        callType: ApiCallType.POST,
        headers: {'Authorization': authorization, "Content-Type": "text/plain"},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class UploadMainImageIdApiCall {
  Future<ApiCallResponse> call({
    required BuildContext context,
    FFUploadedFile? file,
    int? mainImageId,
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
        ApiCallOptions(
          callName: 'UploudImageApi',
          apiUrl: '$baseUrl/api/vehicle/uploadMainImage/$mainImageId',
          callType: ApiCallType.POST,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authorization',
            'Accept': 'application/json',
          },
          params: {'image': file},
          bodyType: BodyType.MULTIPART,
          returnBody: true,
          encodeBodyUtf8: false,
          decodeUtf8: false,
          cache: false,
          alwaysAllowBody: false,
        ),
        MadaApiGroupGroup.interceptors);
  }
}

class UploadSecImageIdApiCall {
  Future<ApiCallResponse> call({
    required BuildContext context,
    FFUploadedFile? file,
    int? mainImageId,
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
        ApiCallOptions(
          callName: 'UploudImageApi',
          apiUrl: '$baseUrl/api/vehicle/uploadPanoramaImage/$mainImageId',
          callType: ApiCallType.POST,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authorization',
            'Accept': 'application/json',
          },
          params: {'image': file},
          bodyType: BodyType.MULTIPART,
          returnBody: true,
          encodeBodyUtf8: false,
          decodeUtf8: false,
          cache: false,
          alwaysAllowBody: false,
        ),
        MadaApiGroupGroup.interceptors);
  }
}

class UploadMedia {
  Future<ApiCallResponse> call({
    required BuildContext context,
    FFUploadedFile? file,
    int? mainImageId,
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
        ApiCallOptions(
          callName: 'UploudImageApi',
          apiUrl: '$baseUrl/api/vehicle/uploadMedia/$mainImageId',
          callType: ApiCallType.POST,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authorization',
            'Accept': 'application/json',
          },
          params: {'image': file},
          bodyType: BodyType.MULTIPART,
          returnBody: true,
          encodeBodyUtf8: false,
          decodeUtf8: false,
          cache: false,
          alwaysAllowBody: false,
        ),
        MadaApiGroupGroup.interceptors);
  }
}

class CreateShilfCall {
  Future<ApiCallResponse> call({
    required String authorization,
    bool? hostAShilf,
    bool? donateAshilf,
    String? hosstType,
    String? phone,
    String? address,
    bool? isShilfDonation,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    final ffApiRequestBody = '''
{
      "hostAShilf": $hostAShilf,
      "donateAshilf": $donateAshilf,
      "hosstType": "$hosstType",
      "phone": "$phone",
      "address": "$address",
      "isShilfDonation": $isShilfDonation
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CreateGiftsCall',
        apiUrl: '$baseUrl/Api/Gifts/POST',
        callType: ApiCallType.POST,
        headers: {'Authorization': authorization, "Content-Type": "text/plain"},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class CreateimageCallWeb {
  Future<ApiCallResponse> call({
    String? name,
    Uint8List? fileBytes,
    String? authorization = '',
  }) async {
    try {
      // Reference to the Firebase Storage location
      Reference ref = FirebaseStorage.instance
          .ref('gs://clicktobolockmerchant.firebasestorage.app/')
          .child('photos/')
          .child(name ?? '');

      // Upload the file
      UploadTask uploadTask = ref.putData(fileBytes!);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL as JSON
      return ApiCallResponse(jsonDecode(stringToJson(downloadUrl)), {}, 200);
    } catch (error) {
      print('Error during upload: $error');
      // Handle errors and return a failure response
      return ApiCallResponse(
          jsonDecode(stringToJson("Error: $error")), {}, 500);
    }
  }

  String stringToJson(String input) {
    final Map<String, dynamic> jsonObject = {"data": input};
    return jsonEncode(jsonObject);
  }
}

class GetAllInvolvingCall {
  Future<ApiCallResponse> call({
    int? pageSize,
    int? pageNumber,
    String? searchText = '',
    String? authorization,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetAllInvolving',
        apiUrl:
            '$baseUrl/Api/Involving/GetAll?PageSize=$pageSize&PageNumber=$pageNumber',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authorization',
        },
        params: {
          'PageSize': pageSize,
          'PageNumber': pageNumber,
          'SearchText': searchText,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class GetAllEventTypsCall {
  Future<ApiCallResponse> call({
    int? pageSize,
    int? pageNumber,
    int? involvingType = 0,
    String? authorization,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAllEventTypsCall',
        apiUrl:
            '$baseUrl/Api/Involving/GetAllEventTypes?PageSize=$pageSize&PageNumber=$pageNumber',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authorization',
        },
        params: {
          'PageSize': pageSize,
          'PageNumber': pageNumber,
          'InvolvingType': involvingType,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class MultiListCall {
  Future<ApiCallResponse> call({required String url}) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAllEventTypsCall',
        apiUrl: '$baseUrl/api$url',
        callType: ApiCallType.GET,
        headers: const {
          'Accept': 'application/json',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class LoginCall {
  Future<ApiCallResponse> call({String? tokenId}) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "idToken": "$tokenId"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'access',
        apiUrl: '$baseUrl/api/auth/access',
        callType: ApiCallType.POST,
        headers: const {"Content-Type": "application/json"},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class CreateVehicleCall {
  Future<ApiCallResponse> call({
    required int brandId,
    required int modelId,
    required int categoryId,
    required List<int> itemsIds,
    bool mostSearched = false,
    bool top = false,
    bool recommended = false,
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final Map<String, dynamic> requestBody = {
      'brand_id': brandId,
      'model_id': modelId,
      'category_id': categoryId,
      'itemsIds': itemsIds,
      'most_searched': mostSearched == false ? 0 : 1,
      'top': top == false ? 0 : 1,
      'recommended': recommended == false ? 0 : 1,
    };

    final String ffApiRequestBody = json.encode(requestBody);

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'access',
        apiUrl: '$baseUrl/api/vehicle/create',
        callType: ApiCallType.POST,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $authorization',
          'Accept': 'application/json',
        },
        params: {
          'brand_id': brandId,
          'model_id': modelId,
          'category_id': categoryId,
          'itemsIds[]': 39,
          'most_searched': mostSearched == false ? 0 : 1,
          'top': top == false ? 0 : 1,
          'recommended': recommended == false ? 0 : 1
        },
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class LoginAnonymouslyUserCall {
  Future<ApiCallResponse> call({String? tokenId}) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tokenId": "$tokenId"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'LoginAnonymouslyUserCall',
        apiUrl: '$baseUrl/Api/Auth/AnonymouslySignIn',
        callType: ApiCallType.POST,
        headers: const {"Content-Type": "text/plain"},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class GetUserByIdCall {
  Future<ApiCallResponse> call({
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetUserById',
        apiUrl: '$baseUrl/Api/User/GetById',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authorization',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class GetSliderCall {
  Future<ApiCallResponse> call({
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetSliderCall',
        apiUrl: '$baseUrl/api/slider/list',
        callType: ApiCallType.GET,
        headers: const {
          "Content-Type": "application/json",
          'Accept': 'application/json'
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class GetCarsCall {
  Future<ApiCallResponse> call({
    bool? mostSearched,
    bool? top,
    bool? recommended,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetSliderCall',
        apiUrl: '$baseUrl/api/vehicle/list',
        callType: ApiCallType.GET,
        headers: const {
          "Content-Type": "application/json",
          'Accept': 'application/json'
        },
        params: {
          'most_searched': mostSearched == true ? 1 : 0,
          'top': top == true ? 1 : 0,
          'recommended': recommended == true ? 1 : 0,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

class GetFavList {
  Future<ApiCallResponse> call({
    String? authorization = '',
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getFavList',
        apiUrl: '$baseUrl/api/getFavList',
        callType: ApiCallType.GET,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $authorization',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}


class AddFavList {
  Future<ApiCallResponse> call({
    String? authorization = '',
    int? id,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getFavList',
        apiUrl: '$baseUrl/api/vehicle/$id/addToFav',
        callType: ApiCallType.POST,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $authorization',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}


class RemoveFavList {
  Future<ApiCallResponse> call({
    String? authorization = '',
    int? id,
  }) async {
    final baseUrl = MadaApiGroupGroup.getBaseUrl();
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getFavList',
        apiUrl: '$baseUrl/api/vehicle/$id/removeFromFav',
        callType: ApiCallType.POST,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $authorization',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      MadaApiGroupGroup.interceptors,
    );
  }
}

/// End BlockToBookApiGroup Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
