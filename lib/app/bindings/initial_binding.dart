import 'package:get/get.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/datasources/local/token_local_data_source.dart';
import 'package:youapp/data/datasources/local/user_local_data_source.dart';
import 'package:youapp/data/datasources/remote/auth_remote_data_source.dart';
import 'package:youapp/data/datasources/remote/user_remote_data_source.dart';
import 'package:youapp/data/datasources/repositories/auth_repository_impl.dart';
import 'package:youapp/data/datasources/repositories/token_repository_impl.dart';
import 'package:youapp/data/datasources/repositories/user_repository_impl.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';
import 'package:youapp/domain/repositories/token_repository.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/auth_use_case.dart';
import 'package:youapp/domain/usecases/get_user_usecase.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/domain/usecases/token_data_use_case.dart';
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
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource());

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
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
      ),
      fenix: true,
    );

    // UseCases
    Get.lazyPut<GetUserDataUseCase>(
      () => GetUserDataUseCase(Get.find<UserRepository>()),
    );
    Get.lazyPut<TokenDataUseCase>(
      () => TokenDataUseCase(Get.find<TokenRepository>()),
    );
    Get.lazyPut<AuthUseCase>(
      () => AuthUseCase(Get.find<AuthRepository>()),
    );

    // Controllers
    Get.lazyPut<SplashController>(
      () => SplashController(
        getUserDataUseCase: Get.find<GetUserDataUseCase>(),
        tokenDataUseCase: Get.find<TokenDataUseCase>(),
      ),
    );
  }
}
