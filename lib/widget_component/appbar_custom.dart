import 'package:dttv/base/base_controller.dart';

class AppBarCustom extends BaseWidget<BaseController> {
  AppBarCustom({
    Key? key,
    this.titleAppBar = '',
    this.widgetTitle,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.callBack,
    this.backgroundColor,
    this.leadingTitile = 'Back',
  }) : super(key: key);

  final String titleAppBar;
  final Widget? widgetTitle;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final VoidCallback? callBack;
  final String leadingTitile;
  final Color? backgroundColor;
  @override
  Widget builder() {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: Get.width / 3,
      actions: <Widget>[
        ...actions ?? <Widget>[],
        const SizedBox(width: 12),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: color.appBaseColor, height: 1),
      ),
      backgroundColor: backgroundColor ?? color.appBaseColor,
      centerTitle: centerTitle,
      leading: _buildLeading(),
      title: widgetTitle ??
          Text(
            titleAppBar,
            style: textStyle.bold(size: sized.fontMedium),
          ),
    );
  }

  Widget? _buildLeading() {
    if (!automaticallyImplyLeading) {
      return null;
    }
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (callBack != null) {
              callBack!();
            } else {
              Get.back();
            }
          },
          icon: Icon(
            Icons.arrow_back,
            color: color.white,
          ),
        ),
      ],
    );

    // IconButton(
    //   onPressed: () {
    //     if (callBack != null) {
    //       callBack!();
    //     } else {
    //       Get.back();
    //     }
    //   },
    //   icon: Row(
    //     children: [
    //       Icon(
    //         Icons.arrow_back,
    //         color: color.white,
    //       ),
    //     ],
    //   ),
    // ),
  }

  @override
  String? screenName() => null;
}
