import 'package:first_project_in_mac/controller/home_controller.dart';
import 'package:first_project_in_mac/model/chat/all_user_list_model.dart';
import 'package:first_project_in_mac/presantation/login_screen.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<HomeController> {
  final Users user;
  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? ""),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: CustomTextField(controller: controller.chatController)),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Const.greenColor),
            child: const Icon(Icons.send),
          )
        ],
      ).paddingOnly(bottom: 10, left: 5),
      body: const Column(
        children: [Text("Message")],
      ),
    );
  }
}
