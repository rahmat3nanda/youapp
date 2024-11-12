import 'package:get/get.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/datasources/local/user_local_data_source.dart';
import 'package:youapp/data/datasources/remote/user_remote_data_source.dart';
import 'package:youapp/data/datasources/repositories/user_repository_impl.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/get_user_usecase.dart';

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

    // Repositories
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        localDataSource: Get.find<UserLocalDataSource>(),
        remoteDataSource: Get.find<UserRemoteDataSource>(),
      ),
      fenix: true,
    );

    // UseCases
    Get.lazyPut<GetUserDataUseCase>(
      () => GetUserDataUseCase(Get.find<UserRepository>()),
    );
  }
}
