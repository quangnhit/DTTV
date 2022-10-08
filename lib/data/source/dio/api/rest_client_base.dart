// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:dttv/config/config.dart';
import 'package:dttv/data/source/dio/rest_client.dart';

class RestClientBase extends RestClient {
  factory RestClientBase() {
    _singleton ??= RestClientBase._internal(AppConfig.config.apiSeverUrl,
        interceptors: null);
    return _singleton!;
  }

  RestClientBase._internal(String baseUrl, {List<Interceptor>? interceptors})
      : super(baseUrl, interceptors);

  static RestClientBase? _singleton;
}
