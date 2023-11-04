import 'dart:convert';

import 'package:first_project_in_mac/http_handler/http_handler.dart';
import 'package:first_project_in_mac/model/auth_models/registration_model.dart';
import 'package:first_project_in_mac/model/chat/all_user_list_model.dart';
import 'package:first_project_in_mac/utils/api_url.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loader = false.obs;
  Rx<AllUserListModel> userListModel = Rx<AllUserListModel>(AllUserListModel());
  Rx<List<Users>?> userList = Rx<List<Users>?>([]);
  TextEditingController chatController = TextEditingController();

  Future<void> getUserList() async {
    loader.value = true;

    ResponseModel response = await HttpHandler.getApiCall(url: ApiUrl.allUser);

    if (response.error == "null") {
      kPrint("userListModel : ${jsonDecode(response.data ?? "")}");

      userListModel?.value =
          AllUserListModel.fromJson(jsonDecode(response.data ?? ""));
      kPrint("userListModel : ${userListModel.value}");
      userList.value = userListModel?.value.users ?? [];
      kPrint("userList : ${userList.value}");
    }
    loader.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserList();
  }
}
