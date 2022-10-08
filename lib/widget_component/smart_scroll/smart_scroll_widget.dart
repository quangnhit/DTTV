// ignore: depend_on_referenced_packages
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:dttv/import.dart';
import 'package:dttv/widget_component/app_loading.dart';
import 'package:dttv/widget_component/smart_load_list_controller.dart';
import 'package:dttv/widget_component/smart_scroll/smart_scroll.dart';
import 'package:dttv/widget_component/smart_scroll/smart_scroll_controller.dart';

class SmartScrollWidget {
  Widget buildSmartListExpanded(SmartScrollController smartScrollController,
          {required Widget child, bool? enablePullDown, bool? enablePullUp}) =>
      Obx(() => Expanded(
            child: smartScrollController.isLoadingPage.value
                ? appLoading
                : SmartScrollView(
                    scrollController:
                        smartScrollController.smartScrollController,
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
