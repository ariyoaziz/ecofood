import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000';

  // Mengirim request POST
  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      ('POST Request: $url');
      ('Request Body: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      ('Response Code: ${response.statusCode}');
      ('Response Body: ${response.body}');

      // Menghandle response dan error
      return _handleResponse(response);
    } on SocketException {
      // Penanganan jika tidak ada koneksi internet
      return {'error': 'No internet connection'};
    } on FormatException {
      // Penanganan jika format response tidak valid
      return {'error': 'Invalid response format from server'};
    } catch (e) {
      // Penanganan kesalahan lain yang tidak terduga
      return {'error': 'An unexpected error occurred: $e'};
    }
  }

  // Menangani response dari server
  Map<String, dynamic> _handleResponse(http.Response response) {
    // Jika status code 200 atau 201, berhasil
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        // Jika gagal parse JSON
        return {'error': 'Failed to parse server response: $e'};
      }
    } else {
      // Jika status code selain 200/201, menghandle error
      try {
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'An unexpected error occurred';
        return {'error': errorMessage};
      } catch (e) {
        // Jika gagal parse response error
        return {'error': 'Failed to parse error response: $e'};
      }
    }
  }

  static verifyOtp(String phone, String otp) {}

  static void sendOtp(String phone) {}
}
