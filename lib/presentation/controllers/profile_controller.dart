import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/token_use_case.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';

class ProfileController extends GetxController {
  final UserUseCase _userUseCase;
  final TokenUseCase _tokenUseCase;
  final ApiServiceDio _dio = Get.find();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  ProfileController({
    required UserUseCase userUseCase,
    required TokenUseCase tokenUseCase,
  })  : _tokenUseCase = tokenUseCase,
        _userUseCase = userUseCase;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void openMenu() async {
    final opt = await showMenu(
      context: Get.context!,
      position: const RelativeRect.fromLTRB(100, kToolbarHeight, 0, 0),
      items: [
        const PopupMenuItem(
          value: 0,
          child: Text("Logout"),
        ),
      ],
    );

    if (opt == 0) {
      signOut();
    }
  }

  void editAvatar() {
    Get.snackbar(
      "Coming Soon!",
      "Feature under development",
      colorText: Colors.white,
      backgroundColor: AppColor.primaryLight,
    );
  }

  void editAbout() {
    Get.snackbar(
      "Coming Soon!",
      "Feature under development",
      colorText: Colors.white,
      backgroundColor: AppColor.primaryLight,
    );
  }

  void editInterest() async {
    await Get.toNamed("/profile/edit/interest");
    fetchUser();
  }

  Future<void> fetchUser() async {
    if (user.value == null) {
      isLoading.value = true;
    }

    try {
      user.value = await _userUseCase.fetch();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      ResponseModel data = ErrorMapper.dioIfNeeded(e);
      Get.snackbar(
        "Failure load data",
        data.message ?? "",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    await _tokenUseCase.remove();
    _dio.setToken(null);
    _userUseCase.destroy();
    Get.snackbar(
      "Success Sign Out",
      "Success Sign Out",
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
    Get.offNamed("/login");
  }
}
