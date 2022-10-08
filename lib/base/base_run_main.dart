// ignore_for_file: depend_on_referenced_packages

import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dttv/config/config.dart';
import 'package:dttv/locator.dart';
import 'package:dttv/main.dart';

class BaseRunMain {
  static Future<void> runMainApp({required BaseConfig config}) async {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await GetStorage.init();
      await SystemChrome.setPreferredOrientations(
          <DeviceOrientation>[DeviceOrientation.portraitUp]);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light));

      await GetStorage.init();
      AppConfig.setEverionment(valueConfig: config);

      await setupLocator();

      runApp(const MyApp());
    }, (Object error, StackTrace stackTrace) {});
  }
}
