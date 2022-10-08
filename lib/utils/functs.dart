import 'dart:collection';

import 'package:dttv/data/source/dio/api_error.dart';
import 'package:dttv/import.dart';

bool isNullOrEmpty(dynamic x) {
  assert(x == null ||
      x is String ||
      x is List ||
      x is Map ||
      x is HashMap ||
      x is Set);

  if (x == null) {
    return true;
  }

  if (x is String) {
    return x.isEmpty;
  }

  if (x is List) {
    return x.isEmpty;
  }

  if (x is Map) {
    return x.isEmpty;
  }

  if (x is HashMap) {
    return x.isEmpty;
  }

  if (x is Set) {
    return x.isEmpty;
  }

  return true;
}

bool isNotNullOrEmpty(dynamic x) {
  assert(x == null ||
      x is String ||
      x is List ||
      x is Map ||
      x is HashMap ||
      x is Set);

  if (x == null) {
    return false;
  }

  if (x is String) {
    return x.isNotEmpty;
  }

  if (x is List) {
    return x.isNotEmpty;
  }

  if (x is Map) {
    return x.isNotEmpty;
  }

  if (x is HashMap) {
    return x.isNotEmpty;
  }

  if (x is Set) {
    return x.isNotEmpty;
  }

  return false;
}

bool isNull(dynamic x) {
  return x == null;
}

bool isNotNull(dynamic x) {
  return x != null;
}

bool rejectIfEqual(List<bool> x) {
  for (final bool xx in x) {
    if (xx) {
      return false;
    }
  }

  return true;
}

String getError(dynamic error, {String mms = ''}) {
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
