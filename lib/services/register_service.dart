import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterService {
  // URL of the registration API
  final String apiUrl = 'http://10.0.2.2/flutterAPI_eco_food/register.php';

  Future<Map<String, dynamic>> registerUser(
      String nama, String email, String phone, String pass) async {
    final Map<String, String> data = {
      'nama': nama,
      'email': email,
      'phone': phone,
      'pass': pass,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Failed to connect to the server.'
        };
      }
    } catch (error) {
      return {'success': false, 'message': 'An error occurred: $error'};
    }
  }
}
