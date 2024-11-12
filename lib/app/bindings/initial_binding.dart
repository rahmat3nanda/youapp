import 'package:get/get.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ApiServiceDio(baseUrl: AppConfig.shared.baseUrlApi),
      fenix: true,
    );
  }
}
