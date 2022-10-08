import 'dart:async';

import 'package:dttv/base/base_run_main.dart';
import 'package:dttv/config/stg.config.dart';

Future<void> main() async {
  BaseRunMain.runMainApp(config: StagingConfig());
}
