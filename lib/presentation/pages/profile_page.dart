import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  _aboutView(),
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

  Widget _aboutView() {
    UserModel? d = controller.user.value;
    if (d?.isAboutEmpty() ?? true) {
      return SectionEdit(
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
      );
    }

    DateTime? birthday;
    if (d?.birthday != null) {
      birthday = DateFormat("yyyy/MM/dd").tryParse(d!.birthday!);
    }

    return SectionEdit(
      title: "About",
      onTap: controller.editAbout,
      child: Column(
        children: [
          _itemView(title: "Display name", value: d?.name),
          _itemView(
            title: "Birthday",
            value: birthday == null
                ? null
                : "${DateFormat("dd/MM/yyyy").format(birthday)} (Age ${(birthday.difference(DateTime.now()).inDays / 365).floor().abs()})",
          ),
          _itemView(title: "Horoscope", value: d?.horoscope),
          _itemView(title: "Zodiac", value: d?.zodiac),
          _itemView(
            title: "Height",
            value: d?.height == null ? null : "${d?.height} cm",
          ),
          _itemView(
            title: "Weight",
            value: d?.weight == null ? null : "${d?.weight} kg",
          ),
        ],
      ),
    );
  }

  Widget _itemView({
    required String title,
    required String? value,
    bool addBottomSpace = true,
  }) {
    if (value == null) {
      return Container();
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Text(
              " $value",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
        if (addBottomSpace) const SizedBox(height: 16),
      ],
    );
  }
}
