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
import 'package:youapp/presentation/widgets/section_edit.dart';

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
                            d == null ? "" : "@${d.username ?? ""},",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SectionEdit(
                    title: "About",
                    onTap: controller.editAbout,
                    child: Text(
                      "Add in your your to help others know you better",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SectionEdit(
                    title: "Interest",
                    onTap: controller.editInterest,
                    child: Text(
                      d?.interests?.joinOrNull(", ") ??
                          "Add in your interest to find a better match",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
