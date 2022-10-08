import 'package:dttv/base/base_controller.dart';

class NotifyController extends BaseController {
  final RxBool hasNewNotification = RxBool(false);

  void setNewNotify() {
    if (!hasNewNotification.value) {
      hasNewNotification.value = true;
    }
  }

  void setClearNewNotify() {
    if (hasNewNotification.value) {
      hasNewNotification.value = false;
    }
  }
}
