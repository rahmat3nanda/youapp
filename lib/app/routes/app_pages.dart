import 'package:get/get.dart';
import 'package:youapp/app/bindings/login_binding.dart';
import 'package:youapp/app/bindings/register_binding.dart';
import 'package:youapp/presentation/pages/login_page.dart';
import 'package:youapp/presentation/pages/register_page.dart';
import 'package:youapp/presentation/pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/login', page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}
