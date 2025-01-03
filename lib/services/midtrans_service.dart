// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransService {
  static const String _baseUrl = "https://app.sandbox.midtrans.com";
  static const String _clientKey = "SB-Mid-client-nj0CRxndbisWNHfg";
  static const String _serverKey = "SB-Mid-server-XvVnVbzpH_ENt-hXoN2k5-YK";

  static Future<String?> getSnapToken(
      Map<String, dynamic> transactionDetails) async {
    final url = Uri.parse("$_baseUrl/snap/v1/transactions");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic ${base64Encode(utf8.encode('$_serverKey:'))}",
        },
        body: jsonEncode(transactionDetails),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return data['token']; // Kembalikan Snap Token
      } else {
        print("Error: ${response.body}");
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
