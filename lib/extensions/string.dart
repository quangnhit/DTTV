// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension StringEx on String {
  bool get isString => RegExp('[a-zA-Z]').hasMatch(this);

  bool get validCharSpec => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this);

  String formatDecimal(String s) {
    return s.replaceAll('', '');
  }

  String formatToDDMMYYYY() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  String formatToDDMMYYYYs() {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this) ?? 0);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  String formatToHHMMSS() {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this) ?? 0);
    final DateFormat formatter = DateFormat('hh:mm:ss');
    return formatter.format(dateTime);
  }

  String formatToYYYYHHMM() {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this) ?? 0);
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  String formatToYearTime() {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this) ?? 0);
    final DateFormat formatter = DateFormat('yyyy/MM/dd hh:mm:ss');
    return formatter.format(dateTime);
  }

  String formatToMMDDHHMM() {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this) ?? 0);
    final DateFormat formatter = DateFormat('MM/dd hh:mm');
    return formatter.format(dateTime);
  }

  String replaceSemicolon({String fromDecimal = ',', String toDecimal = ''}) {
    return replaceAll(fromDecimal, toDecimal);
  }

  DateTime convertStringToDate() {
    return DateFormat('dd/MM/yyyy').parse(this);
  }

  // 2022-05-24T10:37:33Z
  DateTime convertToDateType1() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
  }

  // 4/26/2022 12:00:00 AM
  DateTime convertToDateType2() {
    return DateFormat('MM/dd/yyyy HH:mm:ss aaa').parse(this);
  }

  num formatNumber() {
    return num.tryParse(replaceSemicolon()) ?? 0;
  }

  String? getTimeH() {
    final DateTime result = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    final DateFormat output = DateFormat('HH:mm');
    return output.format(result);
  }

  String? getTimeD() {
    final DateTime result = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    final DateFormat output = DateFormat('dd/MM');
    return output.format(result);
  }

  String? getTimeDDMMYYYY() {
    final DateTime result = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    final DateFormat output = DateFormat('dd/MM/yyyy');
    return output.format(result);
  }

  double get parseNumeric => double.parse(this);

  bool validateEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool validateMobile() {
    return RegExp(r'(0[3|5|7|8|9])+([0-9]{8})\b').hasMatch(this);
  }
}

extension StringExNull on String? {
  bool get isStringNotEmpty => this != null && this!.trim().isNotEmpty;

  bool get isStringEmpty => this != null && this!.trim().isEmpty;

  bool get isString => RegExp('[a-zA-Z]').hasMatch(this!);

  bool get isNumeric {
    if (this == null) {
      return false;
    }
    return double.tryParse(this!) != null;
  }
}
