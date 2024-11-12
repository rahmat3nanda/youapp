import 'package:get/get.dart';
import 'package:youapp/presentation/pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/splash', page: () => const SplashPage()),
  ];
}
