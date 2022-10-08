import 'package:dttv/global/app_const.dart';
import 'package:dttv/global/app_theme.dart';
import 'package:dttv/import.dart';
import 'package:dttv/utils/localization_service.dart';

export 'package:flutter/material.dart';

mixin BaseMixin {
  AppTheme get color => Get.find<AppThemeBase>().theme;

  bool get vn => LocalizationService.locale.languageCode == AppConst.langVI;

  AppTextStyle get textStyle => AppTextStyle.share;

  AppSized get sized => AppSized.share;
}

mixin MixinWidget<T extends StatelessWidget> on BaseMixin {}
