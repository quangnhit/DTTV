// ignore: depend_on_referenced_packages
import 'package:package_info_plus/package_info_plus.dart';

class GlobalDataManager {
  factory GlobalDataManager() {
    return _singleton;
  }

  GlobalDataManager._internal() {
    _getVersionApp();
  }

  static final GlobalDataManager _singleton = GlobalDataManager._internal();

  DateTime? _tradeDate;
  DateTime get tradeDate => _tradeDate ?? DateTime.now();

  String? version;

  Future<void> _getVersionApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = '${packageInfo.version}.${packageInfo.buildNumber}';
  }
}
