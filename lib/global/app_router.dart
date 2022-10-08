import 'package:dttv/import.dart';
import 'package:dttv/pages/dash_board/dash_board_page.dart';
import 'package:dttv/pages/signin/signin_page.dart';
import 'package:dttv/pages/signup/signup_page.dart';
import 'package:dttv/pages/splash/splash_page.dart';

class AppRouter {
  static const String routerSplash = '/splash';
  static const String routerDashBoard = '/dashBoard';
  static const String routerSignPage = '/signin';
  static const String routerSignupPage = '/signup';
  static const String routerNotFoundURL = '/routerNotFoundURL';

  static List<GetPage<dynamic>> getPages = <GetPage<dynamic>>[
    GetPage<SplashPage>(
      name: routerSplash,
      page: () => SplashPage(),
    ),
    GetPage<DashBoardPage>(
      name: routerDashBoard,
      page: () => DashBoardPage(),
    ),
    GetPage<SignInPage>(
      name: routerSignPage,
      page: () => SignInPage(),
    ),
    GetPage<SignupPage>(
      name: routerSignupPage,
      page: () => SignupPage(),
    ),
  ];
}
