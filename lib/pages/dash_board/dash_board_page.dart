import 'package:dttv/import.dart';
import 'package:dttv/pages/dash_board/custom_navigation.dart';
import 'package:dttv/pages/dash_board/dash_board_controller.dart';
import 'package:dttv/widget_component/appbar_custom.dart';

class DashBoardPage extends BaseScreen<DashBoardController> {
  DashBoardPage({super.key});
  @override
  Widget builder() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar,
        body: Obx(
          () => IndexedStack(
            index: controller.currentTabIndex.value,
            children: controller.pageList,
          ),
        ),

        bottomNavigationBar: CustomNavigation(
          onPress: (index) => controller.switchPage(index: index),
          backgroundColor: color.white,
          activeIconColor: color.white,
          circleColor: color.appBaseColor,
          inactiveIconColor: color.appBaseColor,
          items: [
            Items(
              icon: const Icon(Icons.home),
              tabName: '11',
              onClick: () {},
            ),
            Items(
              icon: const Icon(Icons.grid_view_sharp),
              tabName: ' 22',
              onClick: () {},
            ),
            Items(
              icon: const Icon(Icons.stacked_bar_chart_outlined),
              tabName: '33',
              onClick: () {},
            ),
            Items(
              icon: const Icon(Icons.credit_card_rounded),
              tabName: '44',
              onClick: () {},
            ),
            Items(
              icon: const Icon(Icons.account_circle_rounded),
              tabName: '55',
              onClick: () {},
            ),
          ],
        ),
        // bottomNavigationBar: Obx(
        //   () => BottomNavigationBar(
        //     onTap: (value) => _controller.switchPage(index: value),
        //     currentIndex: _controller.currentTabIndex.value,
        //     backgroundColor: color.white,
        //     selectedItemColor: Colors.red,
        //     type: BottomNavigationBarType.fixed,
        //     items: <BottomNavigationBarItem>[
        //       _buildBottomNvBarItem(title: 'Home', iconData: Icons.home),
        //       _buildBottomNvBarItem(
        //           title: 'Page1', iconData: Icons.access_alarm_rounded),
        //       _buildBottomNvBarItem(title: 'Page 2', iconData: Icons.message),
        //       _buildBottomNvBarItem(title: 'Page 2', iconData: Icons.message),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  PreferredSizeWidget get _buildAppBar => PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBarCustom(
            // leadingIcon: Icons.link,
            titleAppBar: 'controller.appBarName',
            callBack: () {},
            actions: [_notice()],
          ),
        ),
      );
  Widget _notice() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.notifications,
          color: color.white,
        ),
        Positioned(
          right: 2,
          bottom: 27,
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: color.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.0,
                color: color.appBaseColor,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '1',
              style: textStyle.regular(
                size: 8.0,
                color: color.appBaseColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  DashBoardController? putController() => DashBoardController();
}
