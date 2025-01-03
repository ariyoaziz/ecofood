import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
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
      debugPrint('POST Request: $url');
      debugPrint('Request Body: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

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

  // Mengirim request GET
  Future<Map<String, dynamic>> getRequest(String endpoint,
      {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      return _handleResponse(response);
    } on SocketException {
      return {'error': 'No internet connection'};
    } on FormatException {
      return {'error': 'Invalid response format from server'};
    } catch (e) {
      return {'error': 'An unexpected error occurred: $e'};
    }
  }

  // Menangani request PUT
  Future<Map<String, dynamic>> putRequest(
      String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } on SocketException {
      return {'error': 'No internet connection'};
    } on FormatException {
      return {'error': 'Invalid response format from server'};
    } catch (e) {
      return {'error': 'An unexpected error occurred: $e'};
    }
  }

  // // Menangani OTP
  // static Future<Map<String, dynamic>> verifyOtp(
  //     String phone, String otp) async {
  //   final url = Uri.parse('http://your-api-url/verify-otp');
  //   final data = {'phone': phone, 'otp': otp};

  //   try {
  //     final response = await http.post(url,
  //         body: jsonEncode(data),
  //         headers: {'Content-Type': 'application/json'});

  //     return _handleResponse(response);
  //   } on SocketException {
  //     return {'error': 'No internet connection'};
  //   } on FormatException {
  //     return {'error': 'Invalid response format from server'};
  //   } catch (e) {
  //     return {'error': 'An unexpected error occurred: $e'};
  //   }
  // }

  // // Mengirim OTP
  // static Future<Map<String, dynamic>> sendOtp(String phone) async {
  //   final url = Uri.parse('http://your-api-url/send-otp');
  //   final data = {'phone': phone};

  //   try {
  //     final response = await http.post(url,
  //         body: jsonEncode(data),
  //         headers: {'Content-Type': 'application/json'});

  //     return _handleResponse(response);
  //   } on SocketException {
  //     return {'error': 'No internet connection'};
  //   } on FormatException {
  //     return {'error': 'Invalid response format from server'};
  //   } catch (e) {
  //     return {'error': 'An unexpected error occurred: $e'};
  //   }
  // }

  // Menangani response dari server
  static Map<String, dynamic> _handleResponse(http.Response response) {
    // Jika status code 200 atau 201, berhasil
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
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
        return {'error': 'Failed to parse error response: $e'};
      }
    }
  }

  // postRequestregist(String s, Map<String, String> data) {}
}
