import 'package:dttv/base/base_controller.dart';
import 'package:dttv/global/app_theme_black.dart';
import 'package:dttv/global/app_theme_bright.dart';
import 'package:dttv/import.dart';

import 'app_base_color.dart';
import 'app_const.dart';

enum AppThemeType { black, bright }

AppTheme baseColor = AppThemeBlack();

abstract class AppTheme with BaseColor {
  ThemeData get theme;
}

class AppThemeBase {
  AppThemeBase() {
    ever(_appTheme, (AppThemeType type) {
      baseColor = theme;
      Get.changeTheme(theme.theme);
      Get.forceAppUpdate();
    });

    _initThemeModeFromSharedPrefs();
  }

  static final Rx<AppThemeType> _appTheme = AppThemeType.black.obs;

  AppThemeType get appTheme => _appTheme.value;

  AppTheme get theme =>
      appTheme == AppThemeType.black ? AppThemeBlack() : AppThemeBright();

  ThemeData get themeData => theme.theme;

  void changeAppTheme(AppThemeType appThemeType) {
    saveThemeModeInSharedPrefs(appThemeType);
  }

  Future<void> _initThemeModeFromSharedPrefs() async {
    final String? themeModeFromPrefs = GetStorage().read(AppConst.keyThemeMode);

    _appTheme.value = themeModeFromPrefs == null ||
            themeModeFromPrefs == AppThemeType.black.toString()
        ? AppThemeType.black
        : AppThemeType.bright;

    baseColor = theme;
  }

  static Future<void> saveThemeModeInSharedPrefs(AppThemeType type) async {
    if (_appTheme.value != type) {
      _appTheme.value = type;
      GetStorage().write(AppConst.keyThemeMode, type.toString());
    }
  }
}
