import 'package:dttv/global/app_path.dart';
import 'package:dttv/import.dart';

class NoDaWidget extends BaseWidget<BaseController> {
  NoDaWidget({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const SizedBox(height: 16),
      SizedBox(
        height: 16,
        width: 16,
        child: Image.asset(
          AppPath.icHome,
          color: color.grey0,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'LocaleKeys.no_data_market.tr',
        style: textStyle.custom(color: color.grey0, size: 10),
      ),
      const SizedBox(height: 16),
    ]));
  }
}
