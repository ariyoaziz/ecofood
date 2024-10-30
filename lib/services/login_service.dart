import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginService extends GetxService {
  Future<bool> login(String emailOrPhone, String password) async {
    final String apiUrl =
        'http://10.0.2.2/flutterAPI_eco_food/login.php'; // Update for local testing

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emailOrPhone': emailOrPhone, 'pass': password}),
      );

      // Debugging: Check status and body response
      ('Response status: ${response.statusCode}');
      ('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          // Optionally, save user data for further use
          return true; // Login successful
        } else {
          ('Login Failed: ${data['message'] ?? 'Invalid email or password'}');
          return false; // Login failed
        }
      } else {
        ('Login Failed: Server error: ${response.statusCode}');
        return false; // Login failed
      }
    } catch (e) {
      ('Error: Something went wrong: $e');
      return false; // Error occurred
    }
  }
}
