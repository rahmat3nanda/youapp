import 'package:get/get.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';
import 'package:youapp/domain/usecases/auth_use_case.dart';
import 'package:youapp/presentation/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthUseCase>(
      () => AuthUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(authUseCase: Get.find<AuthUseCase>()),
      fenix: true,
    );
  }
}
