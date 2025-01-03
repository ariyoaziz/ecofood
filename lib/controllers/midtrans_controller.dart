import 'dart:convert'; // Untuk base64Encode, utf8, jsonEncode, jsonDecode
import 'package:http/http.dart' as http; // Untuk http request

class MidtransController {
  // API Key dari Midtrans (gunakan yang sesuai dengan akun anda)
  static const String _apiKey = "SB-Mid-server-I1RyTaqUueTz48P4Tbmuj-6_";
  static const String _baseUrl =
      "https://app.sandbox.midtrans.com/snap/v1/transactions";

  // Fungsi untuk membuat transaksi
  Future<String> createTransaction(double totalPrice, String userName,
      String userEmail, String userPhone) async {
    final String orderId = "order-${DateTime.now().millisecondsSinceEpoch}";

    // Memastikan harga dikirim dalam satuan sen
    final Map<String, dynamic> transactionDetails = {
      "transaction_details": {
        "order_id": orderId,
        "gross_amount":
            (totalPrice * 100).toInt(), // Menghitung dengan satuan sen
      },
      "customer_details": {
        "first_name": userName,
        "email": userEmail,
        "phone": userPhone,
      }
    };

    try {
      // Debugging data yang dikirim
      print('Data yang dikirim ke Midtrans API: $transactionDetails');

      // Encode API Key menggunakan base64
      String encodedApiKey = base64Encode(utf8.encode(_apiKey));

      // Melakukan HTTP request untuk membuat transaksi
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic $encodedApiKey", // Authorization menggunakan base64
        },
        body: jsonEncode(transactionDetails),
      );

      if (response.statusCode == 200) {
        // Mendecode response dari API untuk mendapatkan token transaksi
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Menampilkan respons dari API untuk debugging
        print('Respons dari Midtrans API: $responseData');

        // Pastikan 'token' ada dalam response
        if (responseData.containsKey('token')) {
          return responseData['token']; // Kembalikan token transaksi
        } else {
          throw Exception('Token tidak ditemukan dalam response');
        }
      } else {
        // Jika ada error, tampilkan pesan error
        print('Error response: ${response.body}');
        throw Exception('Gagal mendapatkan Snap Token: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error lain, misalnya koneksi internet
      print('Error: $e');
      throw Exception('Terjadi kesalahan saat membuat transaksi');
    }
  }
}
