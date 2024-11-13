import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youapp/app/constants/app_icon.dart';
import 'package:youapp/app/helpers/string_join.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/presentation/controllers/profile_controller.dart';
import 'package:youapp/presentation/widgets/loading_overlay.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        UserModel? d = controller.user.value;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              d == null ? "" : "@${d.username ?? ""}",
              style: const TextStyle(fontSize: 17),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: controller.openMenu,
                icon: SvgPicture.asset(AppIcon.more),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 6,
                ),
                children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.formField,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 16,
                          left: 12,
                          child: Text(
                            d == null ? "" : "@${d.username ?? ""}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 2,
                          child: IconButton(
                            onPressed: controller.editAvatar,
                            icon: SvgPicture.asset(AppIcon.edit),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  _infoView(
                    title: "About",
                    value: "Add in your your to help others know you better",
                    onTap: controller.editAbout,
                  ),
                  const SizedBox(height: 18),
                  _infoView(
                    title: "Interest",
                    value: d?.interests?.joinOrNull(", ") ??
                        "Add in your interest to find a better match",
                    onTap: controller.editInterest,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoView({
    required String title,
    required String value,
    Function()? onTap,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color.lerp(AppColor.primary, Colors.white, 0.025),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 2,
          child: IconButton(
            onPressed: onTap,
            icon: SvgPicture.asset(
              AppIcon.edit,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
