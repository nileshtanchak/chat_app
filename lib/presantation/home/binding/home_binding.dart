import 'package:first_project_in_mac/presantation/home/controller/home_controller.dart';
import 'package:first_project_in_mac/presantation/setting/controller/setting_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
