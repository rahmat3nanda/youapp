import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/constants/app_log.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/get_user_usecase.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;
  late AnimationController animationController;

  final GetUserDataUseCase getUserDataUseCase;

  SplashController(this.getUserDataUseCase);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    // Initialize animation controller for splash animation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Start animation and fetch user data
    animationController.forward();
    fetchUserData();

    // Listen for animation completion
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed && !isLoading.value) {
        // Delay slightly after animation to ensure readiness
        await Future.delayed(const Duration(milliseconds: 500));
        _navigateToLogin();
      }
    });

    // React to changes in `isLoading`
    ever(isLoading, (bool loading) {
      if (!loading && animationController.isCompleted) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    AppLog.print("Routing to Login");
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      user.value = await getUserDataUseCase.executeLocal();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
