import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/presentation/controllers/profile_edit_about_controller.dart';
import 'package:youapp/presentation/widgets/loading_overlay.dart';
import 'package:youapp/app/helpers/string_join.dart';
import 'package:youapp/presentation/widgets/section_edit.dart';

class ProfileEditAboutPage extends StatelessWidget {
  ProfileEditAboutPage({super.key});

  final controller = Get.find<ProfileEditAboutController>();

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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                    action: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: controller.save,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            "Save & Update",
                            style: TextStyle(
                              color: AppColor.accent,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: _formView(),
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

  Widget _formView() {
    return Form(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: controller.addImage,
              child: Row(
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColor.accent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Add image",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          _itemView(
            title: "Display name",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.nameController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(hintText: "Enter name"),
            ),
          ),
          const SizedBox(height: 12),
          _itemView(
            title: "Birthday",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.birthDateController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.end,
              onTap: controller.pickBirthdate,
              decoration: const InputDecoration(hintText: "DD MM YYYY"),
            ),
          ),
          const SizedBox(height: 12),
          _itemView(
            title: "Horoscope",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.horoscopeController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.end,
              enabled: false,
              decoration: const InputDecoration(hintText: "--"),
            ),
          ),
          const SizedBox(height: 12),
          _itemView(
            title: "Zodiac",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.zodiacController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.end,
              enabled: false,
              decoration: const InputDecoration(hintText: "--"),
            ),
          ),
          const SizedBox(height: 12),
          _itemView(
            title: "Height",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.heightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(hintText: "Add height"),
            ),
          ),
          const SizedBox(height: 12),
          _itemView(
            title: "Weight",
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.done,
              controller: controller.weightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(hintText: "Add weight"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemView({required String title, required Widget child}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "$title:",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
