import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/domain/usecases/auth_use_case.dart';

class RegisterController extends GetxController {
  final AuthUseCase _authUseCase;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final Rx<ResponseModel?> error = Rx<ResponseModel?>(null);
  final RxBool obscure = true.obs;
  final RxBool obscureConfirm = true.obs;
  final RxBool buttonEnabled = false.obs;
  final RxBool isLoading = false.obs;

  RegisterController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    obscure.value = !obscure.value;
  }

  void toggleConfirmObscure() {
    obscureConfirm.value = !obscureConfirm.value;
  }

  void checkForm() {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text;
    String passwordConfirm = passwordConfirmController.text;

    buttonEnabled.value = email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirm.isNotEmpty;
  }

  void navigateRegister() {
    Get.offNamed("/login");
  }

  Future<void> register() async {
    Get.focusScope?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String username = emailController.text.trim();
      String password = passwordController.text;
      String passwordConfirm = passwordConfirmController.text;

      if (password != passwordConfirm) {
        error.value = ResponseModel(message: "Password didn't match!");
        return;
      }

      error.value = null;
      isLoading.value = true;

      try {
        ResponseModel data = await _authUseCase.register(
          email: email,
          username: username,
          password: password,
        );

        emailController.text = "";
        usernameController.text = "";
        passwordController.text = "";
        passwordConfirmController.text = "";
        isLoading.value = false;

        if (data.code == 201 &&
            (data.message?.toLowerCase() ?? "").contains("success")) {
          Get.snackbar(
            "Success Register",
            data.message ?? "",
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );

          return;
        }

        throw data;
      } catch (e) {
        isLoading.value = false;
        error.value = ErrorMapper.dioIfNeeded(e);
      }
    }
  }
}
