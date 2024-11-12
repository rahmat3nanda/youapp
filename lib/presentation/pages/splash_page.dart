import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/constants/app_string.dart';
import 'package:youapp/presentation/controllers/splash_controller.dart';
import 'package:youapp/presentation/widgets/app_scafold.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeOut,
          ),
          child: const Center(
            child: Text(
              AppString.appName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
