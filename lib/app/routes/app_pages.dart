import 'package:get/get.dart';
import 'package:youapp/app/bindings/profile_edit_about_binding.dart';
import 'package:youapp/app/bindings/profile_edit_interest_binding.dart';
import 'package:youapp/app/bindings/login_binding.dart';
import 'package:youapp/app/bindings/profile_binding.dart';
import 'package:youapp/app/bindings/register_binding.dart';
import 'package:youapp/presentation/pages/profile_edit_about_page.dart';
import 'package:youapp/presentation/pages/profile_edit_interest_page.dart';
import 'package:youapp/presentation/pages/login_page.dart';
import 'package:youapp/presentation/pages/profile_page.dart';
import 'package:youapp/presentation/pages/register_page.dart';
import 'package:youapp/presentation/pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/edit/interest',
      page: () => ProfileEditInterestPage(),
      binding: ProfileEditInterestBinding(),
    ),
    GetPage(
      name: '/profile/edit/about',
      page: () => ProfileEditAboutPage(),
      binding: ProfileEditAboutBinding(),
    ),
  ];
}
