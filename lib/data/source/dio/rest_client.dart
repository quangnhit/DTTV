// ignore_for_file: depend_on_referenced_packages

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'api_error.dart';
import 'interceptors.dart';

class RestClient {
  RestClient(
    this.baseUrl,
    List<Interceptor>? interceptors, {
    Duration timeout = defaultTimeout,
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout.inMilliseconds,
      receiveTimeout: timeout.inMilliseconds,
      contentType: formUrlEncodedContentType,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    final CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.addAll(<Interceptor>[
      SessionInterceptor(),
      LoggingInterceptor(),
      ...interceptors ?? <Interceptor>[]
    ]);
    _dio.interceptors.add(RefreshTokenInterceptor(_dio));
  }
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const String formUrlEncodedContentType =
      'application/x-www-form-urlencoded;charset=UTF-8';
  final String baseUrl;
  late Dio _dio;

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.patch<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  ApiError _mapError(dynamic e) {
    if (e is DioError) {
      String? code = e.response?.statusCode.toString();

      switch (e.type) {
        case DioErrorType.sendTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          return ApiError(message: '${'ERRRRRR'} ${_getCode(code)}');
        case DioErrorType.response:
          if (code!.isNotEmpty) {
            code.replaceAll('-', '_');
          }
          // Bắt riêng lỗi 500 - Internal Server Error
          if ((code == '500') ||
              code == '501' ||
              code == '502' ||
              code == '503') {
            return ApiError(
                errorCode: code, message: '${'ERRRRRR'} ${_getCode(code)}');
          }

          String? msg = 'ERROR$code'.tr;

          if (e.response?.data != null && e.response?.data is Map) {
            try {
              final dynamic errorData = e.response!.data;
              code =
                  (errorData['code']?.toString() ?? code).replaceAll('-', '_');

              msg = 'ERROR$code'.tr;

              if (msg.startsWith('ERROR')) {
                msg = '';
              }

              if (msg.isEmpty) {
                msg = '${'ERRRRRR'} ${_getCode(code)}';
              }
            } catch (error) {
              /// Không cần print ở đây trong intercepter đã log rồi
            }
          }

          return ApiError(
            errorCode: code,
            message: msg,
            extraData: e.response?.data,
          );
        case DioErrorType.cancel:
        case DioErrorType.other:
        default:
          return ApiError(
            errorCode: '${e.error}',
            message: '${'ERRRRRR'} ${e.error}',
            extraData: e.response?.data,
          );
      }
    }

    if (e is ApiError) {
      return ApiError(
          errorCode: e.errorCode,
          message: '${'ERRRRRR'} ${_getCode(e.errorCode)}');
    }

    return ApiError(
      errorCode: '${e.errorCode}',
      message: 'ERRRRRR',
      extraData: e?.data,
    );
  }

  dynamic _mapResponse(dynamic response) {
    if (response is Map && response['status'] == 'Fail') {
      final Map<String, dynamic>? error =
          response['error'] as Map<String, dynamic>?;

      throw ApiError(
          errorCode: error?['code'] as String?,
          message: error?['message'] as String?);
    }

    if (response is Map &&
        response['error'] != '' &&
        response['error'] != null) {
      throw ApiError(
          // error: response['error'] as String?,
          // message: response['error_description'] as String?,
          extraData: response);
    }
    return response;
  }

  String _getCode(String? code) =>
      (code != null && code.isNotEmpty && !code.contains('null'))
          ? '[$code]'
          : '';
}
