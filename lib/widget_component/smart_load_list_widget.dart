// ignore: depend_on_referenced_packages
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dttv/import.dart';
import 'package:dttv/widget_component/app_loading.dart';
import 'package:dttv/widget_component/smart_load_list_controller.dart';

class SmartLoadListWidget {
  Widget buildSmartListExpanded(SmartLoadListController controller,
          {Widget? child, bool? enablePullDown, bool? enablePullUp}) =>
      Obx(() => Expanded(
            child: controller.isLoadingPage.value
                ? appLoading
                : SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: enablePullDown ?? true,
                    enablePullUp: enablePullUp ?? false,
                    onLoading: controller.onLoadMore,
                    onRefresh: controller.onRefresh,
                    child: child,
                  ),
          ));

  SmartRefresher buildSmartList(SmartLoadListController controller,
          {Widget? child, bool? enablePullDown, bool? enablePullUp}) =>
      SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: enablePullDown ?? true,
        enablePullUp: enablePullUp ?? false,
        onLoading: controller.onLoadMore,
        onRefresh: controller.onRefresh,
        child: child,
      );
}
