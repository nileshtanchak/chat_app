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
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Row(
          children: [
            Expanded(
                child: CustomTextField(controller: controller.chatController)),
            GestureDetector(
              onTap: () {
                kPrint("User:: $user");
                controller.onSendMessagePressed(
                    controller.chatController.text.trim(),
                    user.id.toString(),
                    user);
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
            ? Center(
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
                          "sender id: ${controller.chatMessages.value[index].sender.id.toString()}");
                      kPrint("user id: ${user.id.toString()}");
                      return Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              alignment: controller
                                          .chatMessages.value[index].sender.id
                                          .toString() !=
                                      user.id.toString()
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(
                                controller.chatMessages.value[index].text ??
                                    "dsfsdf",
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
      }),
    );
  }
}
