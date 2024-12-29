// File: password_controller.dart
import 'package:flutter/material.dart';
import 'package:ecofood/services/password_service.dart';

class PasswordController {
  final PasswordService _passwordService = PasswordService();

  // Change Password
  Future<void> changePassword(BuildContext context,
      {required String phone,
      required String oldPassword,
      required String newPassword}) async {
    try {
      if ([phone, oldPassword, newPassword].any((field) => field.isEmpty)) {
        _showErrorDialog(context, 'All fields are required');
        return;
      }

      final response = await _passwordService.changePassword(
          phone, oldPassword, newPassword);
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
