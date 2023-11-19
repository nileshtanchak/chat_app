import 'package:first_project_in_mac/controller/auth_controller.dart';
import 'package:first_project_in_mac/presantation/login_screen.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends GetView<AuthController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Registration",
              style: TextStyle(fontSize: 32, color: Const.primaryColor),
            ),
          ),
          Const.customSizedBox(height: 25),
          const Text("Email"),
          Const.customSizedBox(height: 10),
          CustomTextField(controller: controller.emailController),
          Const.customSizedBox(height: 25),
          const Text("Password"),
          Const.customSizedBox(height: 10),
          CustomTextField(controller: controller.passwordController),
          Const.customSizedBox(height: 25),
          Obx(
            () {
              return controller.loader.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AppButton(
                      title: "Register",
                      onTap: () => controller.registerApiCall());
            },
          ),
          Const.customSizedBox(height: 25),
          GestureDetector(
              onTap: () {
                Get.off(const LoginScreen());
              },
              child: const Center(child: Text("Already Register? Login"))),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
