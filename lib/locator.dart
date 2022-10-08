import 'package:dttv/controller/global_data_manager.dart';
import 'package:dttv/data/source/dio/api/rest_client_base.dart';
import 'package:dttv/global/app_theme.dart';
import 'package:dttv/loading_wrapper.dart';
import 'package:dttv/import.dart';

Future<void> setupLocator() async {
  Get.put<AppThemeBase>(AppThemeBase());

  Get.put<LoadingController>(LoadingController());

  Get.put<RestClientBase>(RestClientBase());

  Get.put<GlobalDataManager>(GlobalDataManager());
}
