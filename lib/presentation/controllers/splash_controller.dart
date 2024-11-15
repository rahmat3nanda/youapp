import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';
import 'package:youapp/domain/usecases/token_use_case.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final Rx<String?> _token = Rx<String?>(null);

  late AnimationController animationController;

  final UserUseCase _userUseCase;
  final TokenUseCase _tokenUseCase;
  final ApiServiceDio _dio = Get.find();

  SplashController({
    required UserUseCase userUseCase,
    required TokenUseCase tokenUseCase,
  })  : _tokenUseCase = tokenUseCase,
        _userUseCase = userUseCase;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animationController.forward();
    fetchUserData();

    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed && !_isLoading.value) {
        await Future.delayed(const Duration(milliseconds: 500));
        _navigate();
      }
    });

    ever(_isLoading, (bool loading) {
      if (!loading && animationController.isCompleted) {
        _navigate();
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _navigate() {
    if (_token.value != null && _user.value != null) {
      Get.offNamed("/profile");
      return;
    }

    Get.offNamed("/login");
  }

  Future<void> fetchUserData() async {
    _isLoading.value = true;
    try {
      _user.value = await _userUseCase.fetchFromLocal();
      await _configToken();
    } catch (e) {
      _isLoading.value = false;
    }
  }

  Future<void> _configToken() async {
    _token.value = await _tokenUseCase.fetch();
    if (_token.value != null) {
      _dio.setToken(_token.value!);
    }

    _isLoading.value = false;
  }
}
