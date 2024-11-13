import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';

class ProfileEditInterestController extends GetxController {
  final UserUseCase _userUseCase;

  final StringTagController tagController = StringTagController();
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  final RxBool isLoading = false.obs;

  ProfileEditInterestController({required UserUseCase userUseCase})
      : _userUseCase = userUseCase;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  @override
  void onClose() {
    tagController.dispose();
    super.onClose();
  }

  Future<void> fetchUser() async {
    isLoading.value = true;
    try {
      user.value = await _userUseCase.fetchFromLocal();

      if (user.value != null) {
        isLoading.value = false;
        _updateTags();
        return;
      }

      user.value = await _userUseCase.fetch();
      isLoading.value = false;
      _updateTags();
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

  void _updateTags() {
    for (String s in (user.value?.interests ?? [])) {
      tagController.onTagSubmitted(s);
    }
  }

  void back() {
    Get.back();
  }

  String? validateTags(String s) {
    if (tagController.getTags!.contains(s)) {
      return "You've already entered that";
    }
    return null;
  }

  Future<void> save() async {
    isLoading.value = true;
    try {
      UserModel current = user.value!;
      current.interests ??= [];
      for (String s in (tagController.getTags ?? [])) {
        current.interests!.add(s);
      }

      UserModel? data = await _userUseCase.update(current);
      Get.snackbar(
        "Success Update",
        "Success update your interest",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );

      user.value = data;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      ResponseModel data = ErrorMapper.dioIfNeeded(e);
      Get.snackbar(
        "Failure update data",
        data.message ?? "",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
