import 'dart:ffi';

import 'package:first_project_in_mac/presantation/home/chat/chat_screen.dart';
import 'package:first_project_in_mac/presantation/home/controller/home_controller.dart';
import 'package:first_project_in_mac/presantation/setting/setting_screen.dart';
import 'package:first_project_in_mac/root_binding/app_pages.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ChatApp"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(AppPages.SETTINGS);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ))
          ],
        ),
        body: controller.loader.value
            ? const Center(child: CupertinoActivityIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.userList.value?.length,
                itemBuilder: (context, index) {
                  return controller.userList.value?[index].email ==
                          box.read("email")
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            controller.joinChatRoom(
                                id1: controller.userList.value![index].id
                                    .toString(),
                                id2: box.read("userId"),
                                username:
                                    controller.userList.value![index].name ??
                                        "");

                            controller.getChatHistory();
                            Get.to(() => ChatScreen(
                                  user: controller.userList.value![index],
                                ));
                          },
                          child: ListTile(
                            leading: const CircleAvatar(),
                            title: Text(controller.userList.value?[index].name
                                    .toString() ??
                                ""),
                          ),
                        );
                },
              ),
      );
    });
  }
}
