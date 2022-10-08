import 'package:flutter/scheduler.dart';
import 'package:dttv/controller/controller_manager.dart';
import 'package:dttv/core_support/base_value_notify.dart';
import 'package:dttv/global/app_log.dart';
import 'package:dttv/import.dart';
import 'package:dttv/loading_wrapper.dart';

export 'package:dttv/import.dart';
export 'package:flutter/material.dart';

abstract class BaseController extends GetxController {
  LoadingController get loading => Get.find<LoadingController>();

  RxNotify<bool> loadingPage = false.objective;

  @override
  void onInit() {
    ControlerManager().currentController.value = Get.currentRoute;
    log.debugPrint('BaseController');
    super.onInit();
  }

  void onResumed() {}

  void showLoading() {
    loading.show();
  }

  void showLoadingWhenInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) => loading.show());
  }

  void hideLoading() {
    loading.hide();
  }

  void showLoadingPage() {
    loadingPage.value = true;
  }

  void hideLoadingPage() {
    loadingPage.value = false;
  }

  @override
  void dispose() {
    loadingPage.value = false;
    loading.hideAll();
    super.dispose();
  }

  AppLog get log => AppLog.log;
}
