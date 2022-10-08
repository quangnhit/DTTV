import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/svg.dart';

Widget iconSvg(
        {required String path, double? height, double? width, Color? color}) =>
    path == ''
        ? const SizedBox()
        : SvgPicture.asset(
            path,
            height: height,
            width: width,
            color: color,
          );
