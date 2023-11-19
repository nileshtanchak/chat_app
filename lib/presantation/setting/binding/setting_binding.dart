import 'package:first_project_in_mac/presantation/setting/controller/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
