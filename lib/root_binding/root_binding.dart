import 'package:first_project_in_mac/controller/auth_controller.dart';
import 'package:first_project_in_mac/controller/home_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
}
