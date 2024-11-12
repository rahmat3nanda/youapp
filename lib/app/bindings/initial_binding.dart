import 'package:get/get.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/datasources/local/token_local_data_source.dart';
import 'package:youapp/data/datasources/local/user_local_data_source.dart';
import 'package:youapp/data/datasources/remote/user_remote_data_source.dart';
import 'package:youapp/data/datasources/repositories/token_repository_impl.dart';
import 'package:youapp/data/datasources/repositories/user_repository_impl.dart';
import 'package:youapp/domain/repositories/token_repository.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/domain/usecases/token_use_case.dart';
import 'package:youapp/presentation/controllers/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // API Service
    Get.lazyPut(
      () => ApiServiceDio(baseUrl: AppConfig.shared.baseUrlApi),
      fenix: true,
    );

    // DataSources
    Get.lazyPut<UserLocalDataSource>(() => UserLocalDataSource());
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSource());
    Get.lazyPut<TokenLocalDataSource>(() => TokenLocalDataSource());

    // Repositories
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        localDataSource: Get.find<UserLocalDataSource>(),
        remoteDataSource: Get.find<UserRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<TokenRepository>(
      () => TokenRepositoryImpl(
        localDataSource: Get.find<TokenLocalDataSource>(),
      ),
      fenix: true,
    );

    // UseCases
    Get.lazyPut<UserUseCase>(
      () => UserUseCase(Get.find<UserRepository>()),
    );
    Get.lazyPut<TokenUseCase>(
      () => TokenUseCase(Get.find<TokenRepository>()),
    );

    // Controllers
    Get.lazyPut<SplashController>(
      () => SplashController(
        userUseCase: Get.find<UserUseCase>(),
        tokenUseCase: Get.find<TokenUseCase>(),
      ),
    );
  }
}
