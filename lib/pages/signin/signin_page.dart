import 'package:dttv/import.dart';
import 'package:dttv/pages/signin/signin_controller.dart';
import 'package:dttv/widget_component/appbar_custom.dart';
import 'package:dttv/widget_component/button/widget_button.dart';
import 'package:dttv/widget_component/text_field/build_input_text.dart';

class SignInPage extends BaseScreen<SigninPageController> {
  SignInPage({super.key});

  @override
  Widget builder() {
    return Scaffold(
      appBar: _buildAppBar,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.sign_in.tr,
                    style: textStyle.bold(
                      size: 26,
                    ),
                  ),
                  Text(
                    LocaleKeys.wc_back.tr,
                    style: textStyle.regular(
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildInputText(
                        hintText: LocaleKeys.enter_phone.tr,
                        controller: TextEditingController(),
                      ),
                      const SizedBox(height: 16.0),
                      BuildInputText(
                        hintText: LocaleKeys.enter_password.tr,
                        controller: TextEditingController(),
                      ),
                      const SizedBox(height: 32.0),
                      WidgetButton(
                        title: LocaleKeys.sign_in.tr,
                        onClick: () {},
                        width: Get.width,
                        bgColor: color.appBaseColor,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        LocaleKeys.forgot_password.tr,
                        style: textStyle.regular(
                          size: 14,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      // Text(
                      //   LocaleKeys.or_use.tr,
                      //   style: textStyle.regular(
                      //     size: 14,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.no_account.tr,
                            style: textStyle.regular(
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.moveSignup(),
                            child: Text(
                              ' ${LocaleKeys.register_now.tr}',
                              style: textStyle.regular(
                                size: 14,
                                color: color.blue500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget get _buildAppBar => PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarCustom(
          automaticallyImplyLeading: true,
          // titleAppBar: LocaleKeys.sign_in.tr,
        ),
      );
  @override
  SigninPageController? putController() => SigninPageController();
}
