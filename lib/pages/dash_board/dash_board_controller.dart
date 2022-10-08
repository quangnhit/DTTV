import 'package:dttv/import.dart';

class DashBoardController extends BaseController {
  RxInt currentTabIndex = 0.obs;
  List<Widget> pageList = [
    Container(color: Colors.blueAccent),
    Container(),
    Container(),
    Container(),
    Container()
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void switchPage({required int index}) => currentTabIndex.value = index;
}
