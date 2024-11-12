import 'package:get/get.dart';
import 'package:youapp/presentation/pages/login_page.dart';
import 'package:youapp/presentation/pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/login', page: () => LoginPage()),
  ];
}
