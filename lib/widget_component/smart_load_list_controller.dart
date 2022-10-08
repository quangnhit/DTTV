import 'package:dttv/import.dart';
// ignore: depend_on_referenced_packages
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class SmartLoadListController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool isLoadingPage = false.obs;

  void onLoadMore();

  void onRefresh();
}
