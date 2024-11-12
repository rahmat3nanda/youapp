import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/auth_use_case.dart';
import 'package:youapp/domain/usecases/user_use_case.dart';
import 'package:youapp/domain/usecases/token_use_case.dart';

class LoginController extends GetxController {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;
  final TokenUseCase _tokenUseCase;
  final ApiServiceDio _dio = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailOrUsernameController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Rx<ResponseModel?> error = Rx<ResponseModel?>(null);
  final RxBool obscure = true.obs;
  final RxBool buttonEnabled = false.obs;
  final RxBool isLoading = false.obs;

  LoginController({
    required AuthUseCase authUseCase,
    required UserUseCase userUseCase,
    required TokenUseCase tokenUseCase,
  })  : _authUseCase = authUseCase,
        _tokenUseCase = tokenUseCase,
        _userUseCase = userUseCase;

  @override
  void onClose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    obscure.value = !obscure.value;
  }

  void checkForm() {
    String user = emailOrUsernameController.text.trim();
    String password = passwordController.text;

    buttonEnabled.value = user.isNotEmpty && password.isNotEmpty;
  }

  void navigateRegister() {
    Get.offNamed("/register");
  }

  Future<void> login() async {
    Get.focusScope?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      String user = emailOrUsernameController.text.trim();
      String password = passwordController.text;
      error.value = null;

      isLoading.value = true;
      try {
        String token = await _authUseCase.login(
          emailOrUsername: user,
          password: password,
        );

        _dio.setToken(token);
        await _tokenUseCase.store(token);
        UserModel? data = await _userUseCase.executeRemote();
        Get.snackbar(
          "Success Login",
          "Welcome ${data?.username ?? ""}!",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        isLoading.value = false;
        // TODO: Route to dashboard
      } catch (e) {
        isLoading.value = false;
        error.value = ErrorMapper.dioIfNeeded(e);
      }
    }
  }
}
