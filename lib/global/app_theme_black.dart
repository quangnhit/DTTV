import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'app_text_style.dart';
import 'app_theme.dart';

class AppThemeBlack extends AppTheme {
  AppTextStyle get textStyle => AppTextStyle.share;

  @override
  ThemeData get theme => ThemeData(
      scaffoldBackgroundColor: baseColor,
      // backgroundColor: neutral800,
      // primaryColor: primary,
      // dialogBackgroundColor: grey90,
      fontFamily: 'SF-REGULAR',
      appBarTheme: _buildAppBarTheme,
      bottomAppBarTheme: _buildBottomAppBarTheme,
      dialogTheme: _buildDialogTheme);

  // appbar
  AppBarTheme get _buildAppBarTheme => AppBarTheme(
        // backgroundColor: grey90,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: grey0),
        // textTheme: TextTheme(),
        titleTextStyle:
            TextStyle(color: grey0, fontSize: 16, fontFamily: 'SF-REGULAR'),
      );

  BottomAppBarTheme get _buildBottomAppBarTheme =>
      const BottomAppBarTheme(elevation: 0);

  DialogTheme get _buildDialogTheme => const DialogTheme(elevation: 0);

  @override
  Color get grey0 => const Color(0xFF000000);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get baseColor => const Color(0xFFFFFFFF);

  @override
  Color get appBaseColor => const Color(0xFFEd7117);

  @override
  Color get blue500 => const Color(0xFF2d95ff);

  @override
  Color get black400 => const Color(0xFF838c95);

  @override
  Color get randomColor =>
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
