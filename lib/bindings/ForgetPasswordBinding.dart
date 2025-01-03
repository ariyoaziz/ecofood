// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ecofood/controllers/auth_controller.dart';
import 'package:ecofood/services/api_service.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Menyuntikkan ApiService dan AuthController untuk ForgetPassword
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthController>(
        () => AuthController(apiService: Get.find<ApiService>()));
  }
}
