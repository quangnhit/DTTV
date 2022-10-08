// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppLog {
  AppLog() {
    loger = Logger('MOBILE-APP');

    Logger.root.level = Level.INFO; // defaults to Level.INFO
    Logger.root.onRecord.listen((LogRecord record) {
      debugPrint(
          '===============================> STATR <===============================');
      debugPrint(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
      debugPrint(
          '===============================> END <===============================');
    });
  }

  static final AppLog log = AppLog();

  // final String? className;

  static late Logger loger;

  void info(dynamic message) {
    if (!kReleaseMode) {
      loger.info(message);
    }
  }

  void warning(dynamic message) {
    if (!kReleaseMode) {
      loger.warning(message);
    }
  }

  void config(dynamic message) {
    if (!kReleaseMode) {
      loger.config(message);
    }
  }

  /// Emit a [info] log event
  void printInfo(dynamic info) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print('\u001b[32m[INFO]: $info\u001b[0m');
    }
  }

  /// Emit a [warning] log event
  void printWarning(dynamic warning) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print('\u001B[34m[WARNING]: $warning\u001b[0m');
    }
  }

  /// Emit a [error] log event
  void printError(dynamic error) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print('\u001b[31m[ERROR]: $error\u001b[0m');
    }
  }

  /// Emit a [error] log event
  void debugPrint(dynamic mms) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(mms);
    }
  }
}
