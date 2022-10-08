import 'package:dttv/base/base_controller.dart';

Widget customLableTitle({
  required String title,
  String? value = '',
  String? unit = '',
  bool? isShow = true,
}) {
  return isShow == true
      ? Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Get.put(AppTextStyle()).regular(size: 14.0)),
              RichText(
                maxLines: 1,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: value,
                      style: Get.put(AppTextStyle()).regular(size: 14.0),
                    ),
                    TextSpan(
                      text: unit,
                      style: Get.put(AppTextStyle()).regular(size: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      : const SizedBox();
}
