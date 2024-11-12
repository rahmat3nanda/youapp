import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/usecases/auth_use_case.dart';
import 'package:youapp/domain/usecases/get_user_usecase.dart';
import 'package:youapp/domain/usecases/token_data_use_case.dart';

class LoginController extends GetxController {
  final AuthUseCase _authUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final TokenDataUseCase _tokenDataUseCase;
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
    required GetUserDataUseCase getUserDataUseCase,
    required TokenDataUseCase tokenDataUseCase,
  })  : _authUseCase = authUseCase,
        _tokenDataUseCase = tokenDataUseCase,
        _getUserDataUseCase = getUserDataUseCase;

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
        await _tokenDataUseCase.store(token);
        UserModel? data = await _getUserDataUseCase.executeRemote();
        Get.snackbar("Success Login", "Welcome ${data?.username ?? ""}!");
        isLoading.value = false;
        // TODO: Route to dashboard
      } catch (e) {
        isLoading.value = false;
        error.value = ErrorMapper.dioIfNeeded(e);
      }
    }
  }
}
