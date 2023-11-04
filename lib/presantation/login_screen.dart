import 'package:first_project_in_mac/controller/auth_controller.dart';
import 'package:first_project_in_mac/presantation/home_screen.dart';
import 'package:first_project_in_mac/presantation/registration_page.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Login",
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
          Obx(() {
            return controller.loader.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : AppButton(
                    title: "Login",
                    onTap: () => controller.loginAPiCall(),
                  );
          }),
          Const.customSizedBox(height: 25),
          GestureDetector(
              onTap: () {
                Get.off(const RegistrationPage());
              },
              child: Center(child: const Text("First Time? Register"))),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Const.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
