// File: auth_service.dart
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  // Register
  Future<Map<String, dynamic>> register(String name, String email, String phone,
      String password, String confirmPassword) async {
    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm_password': confirmPassword,
    };
    return await _apiService.postRequest('/auth/register', data);
  }

  // Login
  Future<Map<String, dynamic>> login(
      String emailOrPhone, String password) async {
    final data = {
      'email_or_phone': emailOrPhone,
      'password': password,
    };
    return await _apiService.postRequest('/auth/login', data);
  }
}
