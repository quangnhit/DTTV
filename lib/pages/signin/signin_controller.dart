import 'package:dttv/base/import_base.dart';
import 'package:dttv/global/app_router.dart';

class SigninPageController extends BaseController {
  final RxBool firtMovePage = false.obs;

  void moveSignup() {
    if (firtMovePage.value) {
      Get.offNamed(AppRouter.routerSignupPage);
    } else {
      Get.toNamed(AppRouter.routerSignupPage);
    }
    if (firtMovePage.value == false) {
      firtMovePage.toggle();
    }
  }
}
