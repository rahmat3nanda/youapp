import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';

class ProfileEditAboutController extends GetxController {
  final UserUseCase _userUseCase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController horoscopeController = TextEditingController();
  final TextEditingController zodiacController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  DateTime? _birthdate;

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  ProfileEditAboutController({required UserUseCase userUseCase})
      : _userUseCase = userUseCase;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void editInterest() async {
    await Get.toNamed("/profile/edit/interest");
    fetchUser();
  }

  void addImage() {
    Get.snackbar(
      "Coming Soon!",
      "Feature under development",
      colorText: Colors.white,
      backgroundColor: AppColor.primaryLight,
    );
  }

  void _setupData() {
    UserModel? d = user.value;
    if (d == null) {
      return;
    }

    if (d.birthday != null) {
      _birthdate = DateFormat("yyyy/MM/dd").tryParse(d.birthday!);
      if (_birthdate != null) {
        birthDateController.text = DateFormat("dd MM yyyy").format(_birthdate!);
      }
    }

    nameController.text = d.name ?? "";
    horoscopeController.text = d.horoscope ?? "--";
    zodiacController.text = d.zodiac ?? "--";
    heightController.text = d.height?.toString() ?? "";
    weightController.text = d.weight?.toString() ?? "";
  }

  void pickBirthdate() async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      _birthdate = selectedDate;
      birthDateController.text = DateFormat("dd MM yyyy").format(selectedDate);
    }
  }

  Future<void> save() async {
    Get.focusScope?.unfocus();
    try {
      UserModel? d = user.value;
      if (d == null) {
        Get.snackbar(
          "Failure save data",
          "Undefined value",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return;
      }

      d.name = nameController.text.trim();
      if (_birthdate != null) {
        d.birthday = DateFormat("yyyy/MM/dd").format(_birthdate!);
      }
      d.height = int.tryParse(heightController.text.trim());
      d.weight = int.tryParse(weightController.text.trim());

      isLoading.value = true;
      user.value = await _userUseCase.update(d);
      isLoading.value = false;

      Get.snackbar(
        "Success save data",
        "Your profile updated",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
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

  Future<void> fetchUser() async {
    if (user.value == null) {
      isLoading.value = true;
    }

    try {
      user.value = await _userUseCase.fetch();
      isLoading.value = false;
      _setupData();
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
}
