import 'package:get/get.dart';
import 'package:otp_login/controllers/login_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
