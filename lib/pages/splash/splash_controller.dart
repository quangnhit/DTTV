import 'package:dttv/base/import_base.dart';
import 'package:dttv/global/app_router.dart';

class SplashController extends BaseController {
  @override
  Future<void> onInit() async {
    await 2500.milliseconds.delay();
    Get.offNamed(AppRouter.routerDashBoard);
    super.onInit();
  }
}
