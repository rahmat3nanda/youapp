import 'package:get/get.dart';
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
import 'package:youapp/domain/usecases/user_use_case.dart';
import 'package:youapp/domain/usecases/token_use_case.dart';
import 'package:youapp/presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // DataSources
    Get.lazyPut<UserLocalDataSource>(() => UserLocalDataSource());
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSource());
    Get.lazyPut<TokenLocalDataSource>(() => TokenLocalDataSource());
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource());

    //Repositories
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

    // Use cases
    Get.lazyPut<UserUseCase>(
      () => UserUseCase(Get.find<UserRepository>()),
    );
    Get.lazyPut<TokenUseCase>(
      () => TokenUseCase(Get.find<TokenRepository>()),
    );
    Get.lazyPut<AuthUseCase>(
      () => AuthUseCase(Get.find<AuthRepository>()),
    );

    // Controller
    Get.lazyPut<LoginController>(
      () => LoginController(
        authUseCase: Get.find<AuthUseCase>(),
        userUseCase: Get.find<UserUseCase>(),
        tokenUseCase: Get.find<TokenUseCase>(),
      ),
      fenix: true,
    );
  }
}
