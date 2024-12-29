// File: auth_controller.dart
import 'package:flutter/material.dart';
import 'package:ecofood/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Login
  Future<void> loginUser(BuildContext context,
      {required String emailOrPhone, required String password}) async {
    try {
      if (emailOrPhone.isEmpty || password.isEmpty) {
        _showErrorDialog(context, 'Please fill in all fields');
        return;
      }

      final response = await _authService.login(emailOrPhone, password);
      if (response.containsKey('error')) {
        _showErrorDialog(context, response['error']);
      } else {
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to home
      }
    } catch (e) {
      _showErrorDialog(
          context, 'An unexpected error occurred. Please try again.');
    }
  }

  // Register
  Future<void> registerUser(BuildContext context,
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword}) async {
    try {
      if ([name, email, phone, password, confirmPassword]
          .any((field) => field.isEmpty)) {
        _showErrorDialog(context, 'All fields are required');
        return;
      }

      if (password != confirmPassword) {
        _showErrorDialog(context, 'Passwords do not match');
        return;
      }

      final response = await _authService.register(
          name, email, phone, password, confirmPassword);
      if (response.containsKey('error')) {
        _showErrorDialog(context, response['error']);
      } else {
        Navigator.pushNamed(context, '/verify'); // Navigate to OTP verification
      }
    } catch (e) {
      _showErrorDialog(
          context, 'An unexpected error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK', style: TextStyle(color: Colors.blue))),
        ],
      ),
    );
  }
}
