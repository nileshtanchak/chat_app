import 'dart:convert';

import 'package:first_project_in_mac/http_handler/http_handler.dart';
import 'package:first_project_in_mac/model/auth_models/login_model.dart';
import 'package:first_project_in_mac/model/auth_models/registration_model.dart';
import 'package:first_project_in_mac/presantation/home_screen.dart';
import 'package:first_project_in_mac/presantation/login_screen.dart';
import 'package:first_project_in_mac/utils/api_url.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool loader = false.obs;
  Rx<RegisterModel?> registerModel = Rx<RegisterModel?>(RegisterModel());
  Rx<LoginModel> loginModel = Rx<LoginModel>(LoginModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registerApiCall() async {
    loader.value = true;

    ResponseModel responseModel =
        await HttpHandler.postApiCAll(url: ApiUrl.registrationUrl, body: {
      "name": emailController.text.split("@")[0],
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    });
    if (responseModel.error == "null") {
      registerModel.value =
          RegisterModel.fromJson(jsonDecode(responseModel.data ?? ""));
      kPrint("registration : ${registerModel.value?.user ?? ""}");

      Get.off(const LoginScreen());
    } else {
      kPrint("registration else");
    }
    loader.value = false;
  }

  loginAPiCall() async {
    loader.value = true;

    ResponseModel responseModel =
        await HttpHandler.postApiCAll(url: ApiUrl.loginUrl, body: {
      "name": emailController.text.split("@")[0],
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    });
    if (responseModel.error == "null") {
      loginModel.value =
          LoginModel.fromJson(jsonDecode(responseModel.data ?? ""));

      box.write("email", loginModel.value.userData?.email ?? "");
      box.write("name", loginModel.value.userData?.name ?? "");
      box.write("userId", loginModel.value.userData?.id ?? "");

      kPrint("loginModel : ${loginModel.value.userData ?? ""}");

      Get.off(const HomeScreen());
    } else {
      kPrint("registration else");
    }
    loader.value = false;
  }
}
