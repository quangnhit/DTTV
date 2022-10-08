import 'package:dttv/import.dart';
import 'package:dttv/pages/splash/animation_widget/animated_text.dart';
import 'package:dttv/pages/splash/splash_controller.dart';

class SplashPage extends BaseScreen<SplashController> {
  SplashPage({super.key});

  @override
  Widget builder() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AnimatedText(
            begin: Offset(-10, 0.0),
            end: Offset(0.0, 0.0),
            text: 'Đấu trường',
          ),
          SizedBox(
            width: 16.0,
          ),
          AnimatedText(
            begin: Offset(0.5, 35),
            end: Offset(0.0, 0.5),
            text: 'Tiếng Việt',
            fontSize: 36.0,
            duration: 2,
            curve: Curves.easeOutBack,
          ),
        ],
      ),
    );
  }

  @override
  SplashController? putController() => SplashController();
}
