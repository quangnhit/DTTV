import 'package:dttv/config/dev.config.dart';
import 'package:dttv/config/product.config.dart';
import 'package:dttv/config/stg.config.dart';

class AppConfig {
  static late BaseConfig config;

  static void setDev() {
    config = DevConfig();
  }

  static void setProd() {
    config = ProductConfig();
  }

  static void setStg() {
    config = StagingConfig();
  }

  static void setEverionment({required BaseConfig valueConfig}) {
    config = valueConfig;
  }
}

abstract class BaseConfig {
  String get apiSeverUrl;
}
