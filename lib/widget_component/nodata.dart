import 'package:dttv/import.dart';

class Nodata extends BaseWidget<BaseController> {
  Nodata({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  Widget builder() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Image.asset(
            //   AppPath.imageEmpty,
            //   color: color.grey0,
            // ),
            const SizedBox(height: 8),
            Text(
              title ?? 'LocaleKeys.nodata.tr',
              style: textStyle.custom(color: color.grey0, size: 13),
            ),
          ],
        ),
      ),
    );
  }
}
