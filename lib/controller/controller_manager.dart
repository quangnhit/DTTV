import 'package:dttv/import.dart';
import 'package:dttv/base/base_controller.dart';

class ControlerManager {
  factory ControlerManager() {
    return _singleton;
  }

  ControlerManager._internal();

  static final ControlerManager _singleton = ControlerManager._internal();

  Rx<String> currentController = ''.obs;
}
