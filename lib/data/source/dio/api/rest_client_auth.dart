// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:dttv/config/config.dart';
import 'package:dttv/data/source/dio/rest_client.dart';

class RestClientAuth extends RestClient {
  factory RestClientAuth() {
    _singleton ??= RestClientAuth._internal(AppConfig.config.apiSeverUrl,
        interceptors: null);
    return _singleton!;
  }

  RestClientAuth._internal(String baseUrl, {List<Interceptor>? interceptors})
      : super(baseUrl, interceptors);

  static RestClientAuth? _singleton;
}
