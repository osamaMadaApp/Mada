import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../app_state.dart';
import '../auth/firebase_auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../general_exports.dart';
import '../structure_main_flow/flutter_mada_util.dart';

class ApiRequest {
  ApiRequest({
    required this.className,
    this.path,
    this.fullUrl,
    this.method = ApiMethods.get,
    this.header,
    this.body,
    this.queryParameters,
    this.formatResponse = false,
    this.defaultHeadersValue = true,
    this.withLoading = false,
    this.withAuth = true,
    this.shouldShowMessage = true,
    this.shouldShowRequestDetails = true,
  });

  // final MyAppController myAppController = Get.find<MyAppController>();
  final String? path;
  final String? fullUrl;
  final ApiMethods method;
  final String? className;
  final Map<String, dynamic>? header;
  final bool withLoading;
  final bool formatResponse;
  final bool shouldShowMessage;
  final bool shouldShowRequestDetails;
  final dynamic body;
  final dynamic queryParameters;
  dynamic response;
  final bool withAuth;
  final bool defaultHeadersValue;

  String authorization() => FFAppState().userModel.isNotEmpty
      ? 'Bearer ${FFAppState().userModel[keyToken]}'
      : '';

  Future<Dio> _dio() async {
    final Map<String, dynamic> defaultHeaders = <String, dynamic>{
      'Content-Type': '*/*',
      'Accept': '*/*',
      'platform': Platform.isAndroid ? 'android' : 'ios',
      keyLanguage: FFAppState().getSelectedLanguge(),
    };

    final Map<String, dynamic> mergedHeaders = <String, dynamic>{
      ...(defaultHeadersValue ? defaultHeaders : <String, dynamic>{}),
      ...(header ?? <String, dynamic>{}),
    };

    if (withAuth) {
      mergedHeaders['Authorization'] = authorization();
    }

    // final Map<String, dynamic> defaultQueryParams = getDefaultQueryParams();
    final Dio dio = Dio(
      BaseOptions(
        headers: mergedHeaders,
        queryParameters: <String, dynamic>{
          ...queryParameters ?? <String, dynamic>{},
        },
      ),
    );

    // Adding interceptor
    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      if (options.headers['Authorization'] != null) {
        if (options.headers['Authorization']
            .toString()
            .replaceAll('Bearer ', '')
            .replaceAll('null', '')
            .isNotEmpty) {
          final header = options.headers['Authorization'];
          final bool isExpired =
              JwtDecoder.isExpired(header.toString().replaceAll('Bearer ', ''));
          if (isExpired) {
            final ApiCallResponse refreshApiCall =
                await MadaApiGroupGroup.refreshApiCall.call(
                    path: baseUrl + apiRefreshToken,
                    token: FFAppState().userModel[keyToken],
                    refreshToken: FFAppState().userModel[keyRefreshToken]);
            if (refreshApiCall.succeeded == true) {
              FFAppState().userModel[keyToken] =
                  refreshApiCall.jsonBody[keyResults][keyToken];
              FFAppState().userModel[keyRefreshToken] =
                  refreshApiCall.jsonBody[keyResults][keyToken];
              options.headers['Authorization'] =
                  'Bearer ${FFAppState().userModel[keyToken]}';
            }
            return handler.next(options);
          } else {
            return handler.next(options);
          }
        } else {
          FFAppState().prefs.clear();
          await authManager.signOut();
          return handler.next(options);
        }
      } else {
        return handler.next(options);
      }
    }));

    return dio;
  }

  Future<void> request({
    Function()? beforeSend,
    Function(dynamic data, dynamic response)? onSuccess,
    Function(dynamic data, dynamic response, dynamic header)?
        onSuccessWithHeader,
    Function(dynamic error)? onError,
  }) async {
    // start request time
    final DateTime startTime = DateTime.now();

    final Dio dio = await _dio();

    try {
      if (withLoading) {
        startLoading();
      }
      switch (method) {
        case ApiMethods.get:
          response = await dio.get(
            fullUrl ?? baseUrl + path!,
          );
          break;
        case ApiMethods.post:
          response = await dio.post(
            fullUrl ?? baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.put:
          response = await dio.put(
            fullUrl ?? baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.delete:
          response = await dio.delete(
            fullUrl ?? baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.patch:
          response = await dio.patch(
            fullUrl ?? (baseUrl + path!),
            data: body,
            queryParameters: queryParameters,
          );
          break;
      }
      final int time = DateTime.now().difference(startTime).inMilliseconds;
      // print response data in console
      if (shouldShowRequestDetails) {
        showRequestDetails(
          method: method.toString(),
          path: path,
          fullUrl: fullUrl,
          formatResponse: formatResponse,
          className: className,
          body: body.toString(),
          headers: dio.options.headers,
          queryParameters: dio.options.queryParameters.toString(),
          response: response.data,
          time: time,
        );
      }

      if (withLoading) {
        dismissLoading();
      }

      if (onSuccess != null) {
        onSuccess(response.data, response.data);
      }
      if (onSuccessWithHeader != null) {
        onSuccessWithHeader(response.data, response.data, response.headers.map);
      }
    } on Exception catch (error) {
      consoleLog(error);

      dismissLoading();
      // request time
      final int time = DateTime.now().difference(startTime).inMilliseconds;

      if (error is DioException) {
        final dynamic errorData = error.response?.data ??
            <String, dynamic>{
              'errors': <Map<String, String>>[
                <String, String>{'message': error.toString()}
              ]
            };
        if (onError != null) {
          onError(errorData);
        }
        if (error.response?.statusCode == 401) {
          consoleLog('The Status code is 401');
          // myAppController.onSignOut();
        }
        // print response error
        if (shouldShowRequestDetails) {
          showRequestDetails(
            method: method.toString(),
            path: path,
            fullUrl: fullUrl,
            formatResponse: formatResponse,
            className: className,
            body: body.toString(),
            headers: dio.options.headers,
            queryParameters: dio.options.queryParameters.toString(),
            response: errorData,
            time: time,
            isError: true,
          );
        }

        //handle DioError here by error type or by error code
        if (shouldShowMessage) {
          consoleLogPretty(errorData['message']);
          showToast(
            errorData['errors'] != null && errorData['errors'].length > 0
                ? errorData['errors'][0]['message']
                : errorData['message'],
          );
        }
      } else {
        // handle another errors
        if (shouldShowRequestDetails) {
          showRequestDetails(
            method: method.toString(),
            path: path,
            fullUrl: fullUrl,
            formatResponse: formatResponse,
            className: className,
            body: body.toString(),
            headers: dio.options.headers,
            queryParameters: dio.options.queryParameters.toString(),
            response: error,
            time: time,
            isError: true,
            otherCatch: true,
          );
        }
      }
    }
  }
}

enum ApiMethods {
  get,
  post,
  put,
  delete,
  patch,
}
