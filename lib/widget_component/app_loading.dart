import 'package:flutter/cupertino.dart';

Widget get appLoading => SizedBox(
      child: Center(
          child: Container(
        padding: const EdgeInsets.all(4.0),
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            color: const Color(0xFF212121).withOpacity(0.6),
            borderRadius: BorderRadius.circular(4.0)),
        child: const CupertinoActivityIndicator(
          color: Color(0xFFB8B8B8),
          radius: 15,
        ),
      )),
    );
