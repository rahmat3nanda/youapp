import 'package:get/get.dart';
import 'package:youapp/data/datasources/local/user_local_data_source.dart';
import 'package:youapp/data/datasources/remote/user_remote_data_source.dart';
import 'package:youapp/data/datasources/repositories/user_repository_impl.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';
import 'package:youapp/presentation/controllers/profile_edit_interest_controller.dart';

class ProfileEditInterestBinding extends Bindings {
  @override
  void dependencies() {
    // DataSources
    Get.lazyPut<UserLocalDataSource>(() => UserLocalDataSource());
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSource());

    //Repositories
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        localDataSource: Get.find<UserLocalDataSource>(),
        remoteDataSource: Get.find<UserRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Use cases
    Get.lazyPut<UserUseCase>(
      () => UserUseCase(Get.find<UserRepository>()),
    );

    // Controller
    Get.lazyPut<ProfileEditInterestController>(
      () => ProfileEditInterestController(userUseCase: Get.find<UserUseCase>()),
      fenix: true,
    );
  }
}
