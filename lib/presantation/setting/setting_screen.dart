import 'package:first_project_in_mac/presantation/auth/login_screen.dart';
import 'package:first_project_in_mac/root_binding/app_pages.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Get.defaultDialog(
                title: "Confirmation Required",
                content: const Text("Are you sure you want to Logout?"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("No")),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                        box.remove("userId");
                        Get.offAllNamed(AppPages.LOGIN);
                      },
                      child: const Text("Yes")),
                ],
              );
            },
            title: const Text("Logout"),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          )
        ],
      ),
    );
  }
}
