import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/presentation/controllers/login_controller.dart';
import 'package:youapp/presentation/widgets/app_scafold.dart';
import 'package:youapp/presentation/widgets/button_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),
              _formView(),
              if (controller.error.value?.message != null)
                const SizedBox(height: 24),
              if (controller.error.value?.message != null)
                Text(
                  controller.error.value?.message ?? "Unknown error",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),
              ButtonWidget(
                onTap: controller.login,
                isActive: controller.buttonEnabled.value,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "No account? "),
                    TextSpan(
                      text: "Register here",
                      style: TextStyle(color: AppColor.accent),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.navigateRegister,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formView() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: controller.emailOrUsernameController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => controller.checkForm(),
            decoration: const InputDecoration(hintText: "Enter Username/Email"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.done,
            controller: controller.passwordController,
            keyboardType: TextInputType.text,
            onChanged: (_) => controller.checkForm(),
            obscureText: controller.obscure.value,
            decoration: InputDecoration(
              hintText: "Enter Password",
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: controller.toggleObscure,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
