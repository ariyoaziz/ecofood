import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_login/services/login_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService loginService = LoginService();

  // Property to manage password visibility
  var isPasswordVisible = false.obs;

  Future<void> login() async {
    String emailOrPhone = emailOrPhoneController.text.trim();
    String password = passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      _showNotification('Input Error', 'Please fill in all fields', Colors.red);
      return;
    }

    bool success = await loginService.login(emailOrPhone, password);
    if (success) {
      // Navigate to home page on successful login
      Get.offAllNamed('/home');
      // Show success notification
      _showNotification('Login Successful', 'Welcome back!', Colors.green);
    } else {
      // Show an error message if login fails
      _showNotification(
          'Login Failed', 'Invalid email or password', Colors.red);
    }
  }

  void _showNotification(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      icon: Icon(
        color == Colors.red ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
