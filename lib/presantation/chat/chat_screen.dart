import 'dart:ffi';

import 'package:first_project_in_mac/controller/home_controller.dart';
import 'package:first_project_in_mac/model/chat/all_user_list_model.dart';
import 'package:first_project_in_mac/presantation/login_screen.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<HomeController> {
  final Users user;
  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(user.name ?? ""),
        actions: [
          controller.isLongPress.value
              ? IconButton(onPressed: () {}, icon: Icon(Icons.delete))
              : SizedBox(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Row(
          children: [
            Expanded(
                child: CustomTextField(controller: controller.chatController)),
            GestureDetector(
              onTap: () {
                if (controller.chatController.text.isNotEmpty) {
                  kPrint("User:: $user");
                  kPrint("User id of chat user:: ${user.id.toString()}");
                  kPrint("User id of login User:: ${box.read("userId")}");
                  controller.onSendMessagePressed(
                      controller.chatController.text.trim(),
                      user.id.toString(),
                      box.read("userId"),
                      user);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Const.greenColor),
                child: const Icon(Icons.send),
              ),
            )
          ],
        ).paddingOnly(bottom: 10, left: 5),
      ),
      body: Obx(() {
        return controller.loader.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : controller.chatMessages.value.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: controller.chatMessages.value.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      kPrint(
                          "new check list:: ${controller.chatMessages.value.length}");
                      kPrint(
                          "sender id: ${controller.chatMessages.value[index].sender.toString()}");
                      kPrint("user id: ${user.id.toString()}");
                      return Align(
                        alignment: controller.chatMessages.value[index].sender
                                    .toString() !=
                                box.read("userId")
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Container(
                              color: controller.chatMessages.value[index]
                                      .isSelected.value
                                  ? Colors.grey.withOpacity(0.4)
                                  : null,
                              child: GestureDetector(
                                onLongPress: () {
                                  controller.chatMessages.value[index]
                                      .isSelected.value = true;
                                  controller.isLongPress.value = true;
                                  controller.update();
                                  print(
                                      "Long Press:: ${controller.chatMessages.value[index].isSelected.value}");
                                },
                                onTap: () {
                                  controller.chatMessages.value[index]
                                      .isSelected.value = false;
                                  controller.isLongPress.value = false;
                                  controller.update();
                                  print(
                                      "Press:: ${controller.chatMessages.value[index].isSelected.value}");
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: controller.chatMessages
                                                  .value[index].sender
                                                  .toString() !=
                                              box.read("userId")
                                          ? Colors.green.shade800
                                          : Colors.grey,
                                      borderRadius: controller.chatMessages
                                                  .value[index].sender
                                                  .toString() !=
                                              box.read("userId")
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))
                                          : const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10))),
                                  child: Text(
                                    controller.chatMessages.value[index].text,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
      }),
    );
  }
}
