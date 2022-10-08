import 'dart:ui';

import 'package:dttv/import.dart';

class AppTextStyle {
  static final AppTextStyle share = AppTextStyle();

  TextStyle bold({
    double? size,
    Color? color,
    Color? backgroundColor,
  }) =>
      custom(
          size: size,
          color: color,
          fontWeight: FontWeight.w700,
          backgroundColor: backgroundColor);

  TextStyle semiBold({
    double? size,
    Color? color,
    Color? backgroundColor,
  }) =>
      custom(
          size: size,
          color: color,
          fontWeight: FontWeight.w600,
          backgroundColor: backgroundColor);

  TextStyle medium({
    double? size,
    Color? color,
    Color? backgroundColor,
  }) =>
      custom(
          size: size,
          color: color,
          fontWeight: FontWeight.w500,
          backgroundColor: backgroundColor);

  TextStyle regular({
    double? size,
    Color? color,
    Color? backgroundColor,
  }) =>
      custom(
          size: size,
          color: color,
          fontWeight: FontWeight.w400,
          backgroundColor: backgroundColor);

  TextStyle custom({
    double? size,
    Color? color,
    Color? backgroundColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.bellota(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: size ?? 14,
      color: color ?? Colors.black,
      fontFeatures: const <FontFeature>[
        FontFeature.tabularFigures(),
      ],
    );
  }

  TextStyle splashFont({
    double? size,
    Color? color,
    Color? backgroundColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.pacifico(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: size ?? 14,
      color: color ?? Colors.black,
      fontFeatures: const <FontFeature>[
        FontFeature.tabularFigures(),
      ],
    );
  }
}
