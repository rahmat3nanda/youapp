import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:youapp/app/styles/app_color.dart';
import 'package:youapp/presentation/controllers/register_controller.dart';
import 'package:youapp/presentation/widgets/app_scafold.dart';
import 'package:youapp/presentation/widgets/button_widget.dart';
import 'package:youapp/presentation/widgets/loading_overlay.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          color: Colors.white.withOpacity(0.4),
          progressIndicator: SpinKitSpinningLines(
            color: AppColor.accent,
            size: 72,
            lineWidth: 4,
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              children: [
                const Text(
                  "Register",
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
                  onTap: controller.register,
                  isActive: controller.buttonEnabled.value,
                  child: const Text(
                    "Register",
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
                      const TextSpan(text: "Have an account? "),
                      TextSpan(
                        text: "Login here",
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
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => controller.checkForm(),
            decoration: const InputDecoration(hintText: "Enter Email"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: controller.usernameController,
            keyboardType: TextInputType.text,
            onChanged: (_) => controller.checkForm(),
            decoration: const InputDecoration(hintText: "Create Username"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: controller.passwordController,
            keyboardType: TextInputType.text,
            onChanged: (_) => controller.checkForm(),
            obscureText: controller.obscure.value,
            decoration: InputDecoration(
              hintText: "Create Password",
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
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.done,
            controller: controller.passwordConfirmController,
            keyboardType: TextInputType.text,
            onChanged: (_) => controller.checkForm(),
            obscureText: controller.obscureConfirm.value,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscureConfirm.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: controller.toggleConfirmObscure,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
