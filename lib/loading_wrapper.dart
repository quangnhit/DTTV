import 'package:dttv/import.dart';

class LoadingWrapper extends BaseScreen<LoadingController> {
  LoadingWrapper({Key? key, this.child}) : super(key: key);

  final Widget? child;
  @override
  Widget builder() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          child ?? const SizedBox(),
          Obx(() => Visibility(
              visible: controller.loadingCtrl.value,
              child: ColoredBox(
                  color: const Color(0xFF131615).withOpacity(0.5),
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.red)))))
        ]));
  }

  @override
  LoadingController? putController() {
    return LoadingController();
  }
}

class LoadingController extends BaseController {
  Rx<bool> loadingCtrl = Rx<bool>(false);
  int _count = 0;

  void show() {
    _count += 1;

    if (_count == 1) {
      loadingCtrl.value = true;
    }
  }

  void hide() {
    if (_count > 0) {
      _count--;
    }

    if (_count == 0) {
      loadingCtrl.value = false;
    }
  }

  void hideAll() {
    _count = 0;

    loadingCtrl.value = false;
  }
}
