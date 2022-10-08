import 'package:dttv/utils/device.dart';

class DeviceManager {
  factory DeviceManager() {
    return _singleton;
  }

  DeviceManager._internal() {
    init();
  }

  static final DeviceManager _singleton = DeviceManager._internal();

  DeviceInfo deviceInfo = DeviceInfo();

  Future<void> init() async {
    deviceInfo = await getDeviceInfo();
  }
}
