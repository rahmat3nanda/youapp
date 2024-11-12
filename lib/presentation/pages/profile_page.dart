import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/presentation/controllers/profile_controller.dart';
import 'package:youapp/presentation/widgets/app_scafold.dart';
import 'package:youapp/presentation/widgets/loading_overlay.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBar: AppBar(
          title: Text(
            controller.user.value == null
                ? ""
                : "@${controller.user.value?.username ?? ""}",
            style: const TextStyle(fontSize: 17),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: controller.openMenu,
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: LoadingOverlay(
          isLoading: controller.isLoading.value,
          color: Colors.white.withOpacity(0.4),
          progressIndicator: SpinKitSpinningLines(
            color: AppColor.accent,
            size: 72,
            lineWidth: 4,
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 6),
              children: const [
                Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
