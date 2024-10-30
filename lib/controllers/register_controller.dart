import 'package:flutter/material.dart'; // Import the material package
import 'package:get/get.dart';
import 'package:otp_login/pages/verify.dart';
import 'package:otp_login/services/register_service.dart';

class RegisterController extends GetxController {
  var nama = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var pass = ''.obs;
  final RegisterService registerService = RegisterService();

  Future<void> register() async {
    final responseData = await registerService.registerUser(
      nama.value,
      email.value,
      phone.value,
      pass.value,
    );

    // Debugging output
    ('Response from API: $responseData'); // Use print for debugging

    if (responseData['success'] != null && responseData['success'] == true) {
      if (responseData['message'] == 'Data Berhasil di Create') {
        Get.offAll(const Verify());

        // Show success notification
        Get.snackbar(
          'Registration Successful',
          'You have successfully registered.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          icon: const Icon(Icons.check, color: Colors.white),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        );
      }
    } else {
      // Show error notification if registration fails
      Get.snackbar(
        'Registration Failed',
        responseData['message'] ?? 'Unknown error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
    }
  }
}
