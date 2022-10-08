import 'package:dttv/data/source/dio/api_error.dart';
import 'package:dttv/utils/functs.dart';
import 'package:dttv/import.dart';

class Utils {
  static String getError(dynamic error, {String mms = ''}) {
    if (error is String) {
      return '$error $mms';
    }

    if (error is ApiError) {
      if (error.extraData != null && error.extraData is Map) {
        if (error.extraData['error_description'] != null) {
          return error.extraData['error_description'].toString();
        }
      }

      if (isNotNullOrEmpty(error.errorCode)) {
        final String msg = 'ERROR${error.errorCode}'.tr;

        if (!msg.startsWith('ERROR')) {
          return '$msg $mms';
        }
      }

      if (isNotNullOrEmpty(error.message)) {
        return error.message ?? mms;
      }

      return mms;
    }

    if (error is Exception) {
      if (isNull(error)) {
        return mms;
      }

      return '$error $mms';
    }

    return mms;
  }
}
