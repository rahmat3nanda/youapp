import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/presentation/controllers/profile_edit_interest_controller.dart';
import 'package:youapp/presentation/widgets/app_scafold.dart';
import 'package:youapp/presentation/widgets/loading_overlay.dart';

class ProfileEditInterestPage extends StatelessWidget {
  ProfileEditInterestPage({super.key});

  final controller = Get.find<ProfileEditInterestController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leadingWidth: 108,
        leading: InkWell(
          onTap: controller.back,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 18),
              Icon(
                CupertinoIcons.back,
                size: 14,
              ),
              SizedBox(width: 10),
              Text(
                "Back",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: controller.save,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Text(
                "Save",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          color: Colors.white.withOpacity(0.4),
          progressIndicator: SpinKitSpinningLines(
            color: AppColor.accent,
            size: 72,
            lineWidth: 4,
          ),
          child: SafeArea(child: _mainView()),
        ),
      ),
    );
  }

  Widget _mainView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const SizedBox(height: 52),
        Text(
          "Tell everyone about yourself",
          style: TextStyle(
            color: AppColor.accent,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "What interest you?",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 35),
        TextFieldTags<String>(
          textfieldTagsController: controller.tagController,
          initialTags: controller.user.value?.interests ?? [],
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: controller.validateTags,
          inputFieldBuilder: (context, inputFieldValues) {
            return TextField(
              onTap: () =>
                  controller.tagController.getFocusNode?.requestFocus(),
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
              onChanged: inputFieldValues.onTagChanged,
              onSubmitted: inputFieldValues.onTagSubmitted,
              decoration: InputDecoration(
                errorText: inputFieldValues.error,
                prefixIcon: inputFieldValues.tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: inputFieldValues.tagScrollController,
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            left: 8,
                          ),
                          child: Wrap(
                            runSpacing: 4.0,
                            spacing: 4.0,
                            children: inputFieldValues.tags.map((tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(tag),
                                    const SizedBox(width: 6),
                                    InkWell(
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      onTap: () =>
                                          inputFieldValues.onTagRemoved(tag),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : null,
              ),
            );
          },
        )
      ],
    );
  }
}
