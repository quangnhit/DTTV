// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dttv/controller/session_manager.dart';
import 'package:dttv/global/app_log.dart';
import 'package:dttv/utils/functs.dart';

class LoggingInterceptor implements InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      debugPrint(
          '=======> [DioError][${err.response?.realUri.path}] ${err.response} <=======');
    }

    // FirebaseRealTimeController.share.logEvent(
    //     tableName: TableFBRT.LOG_ERROR_API,
    //     event: EventFBRT.ERROR,
    //     subfix: (err.response?.realUri.path ?? err.requestOptions.path)
    //         .replaceAll('/', '\\'),
    //     data: <String, dynamic>{
    //       'err': err.error,
    //       'url': err.response?.realUri.path,
    //       'response': err.response?.data,
    //       // 'requestOptions': err.requestOptions.data,
    //     });

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLog.log
        .info('=======> ${options.method} ${options.baseUrl}${options.path}');
    if (SessionManager().accessToken.isNotEmpty) {
      options.headers.addAll(<String, dynamic>{
        'x-xsrf-token': (options.headers[HttpHeaders.cookieHeader] as String)
            .replaceAll('XSRF-TOKEN=', '')
      });
      options.headers[HttpHeaders.cookieHeader] =
          'ACCESS-TOKEN=${SessionManager().accessToken};${options.headers[HttpHeaders.cookieHeader]}';
    }
    debugPrint('=======> HEADER: ${options.headers}');

    if (options.data != null) {
      AppLog.log.debugPrint('=======> [REQUEST DATA]: ${options.data}');
    } else if (options.queryParameters.isNotEmpty) {
      AppLog.log.debugPrint(
          '=======> [REQUEST queryParameters]: ${options.queryParameters}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(
        '<=== ${response.statusCode} [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path}');

    if (response.requestOptions.data != null) {
      AppLog.log
          .debugPrint('<=== [RESPONSE DATA]: ${response.requestOptions.data}');
    } else if (response.requestOptions.queryParameters.isNotEmpty) {
      AppLog.log.debugPrint(
          '<=== [RESPONSE queryParameters]: ${response.requestOptions.queryParameters}');
    }

    if (response.data is Map || response.data is List) {
      debugPrint(jsonEncode(response.data));
    } else {
      debugPrint('${response.data}');
    }

    return handler.next(response);
  }
}

class SessionInterceptor implements InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll(<String, dynamic>{
    //   'deviceId': DeviceManager().deviceInfo.deviceId,
    //   'User-Agent': jsonEncode(DeviceManager().deviceInfo.deviceInfo),
    // });

    // if (SessionState().session.isNotEmpty &&
    //     AppEndPoint.settingParams != options.path) {
    // if (SessionManager().accessToken.isNotEmpty) {
    //   options.headers.addAll(<String, dynamic>{
    //     'Authorization': 'Bearer ${SessionManager().accessToken}'
    //   });
    // }

    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (response.data is String && isNotNullOrEmpty(response.data)) {
      response.data = jsonDecode(response.data as String);
    }

    if (response.data is Map) {
      switch (response.data['errorCode']) {
      }
    }

    return handler.next(response);
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this.dio);

  final Dio dio;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handleError(
      code: err.response?.data['code'] ?? 0,
      path: err.response?.realUri.path ?? '',
    );

    return handler.next(err);
  }

  void handleError({required int code, String path = ''}) {
    switch (code) {
    }
  }
}
