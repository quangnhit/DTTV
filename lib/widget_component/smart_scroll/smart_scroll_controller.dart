import 'package:dttv/import.dart';
// ignore: depend_on_referenced_packages

abstract class SmartScrollController {
  final ScrollController smartScrollController = ScrollController();
  final RxBool isLoadingPage = false.obs;

  void onLoadMore();

  void onRefresh();

  void animateTo();
}
