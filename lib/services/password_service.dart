// File: password_service.dart
import 'api_service.dart';

class PasswordService {
  final ApiService _apiService = ApiService();

  // Change Password
  Future<Map<String, dynamic>> changePassword(
      String phone, String oldPassword, String newPassword) async {
    final data = {
      'phone': phone,
      'old_password': oldPassword,
      'new_password': newPassword,
    };
    return await _apiService.postRequest('/change-password', data);
  }
}
