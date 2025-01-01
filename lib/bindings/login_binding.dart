import 'package:get/get.dart';
import 'package:ecofood/controllers/auth_controller.dart';
import 'package:ecofood/services/api_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Menyuntikkan ApiService ke dalam AuthController
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthController>(() => AuthController(apiService: Get.find()));
  }
}
