import 'api_service.dart';

class OtpService {
  final ApiService _apiService = ApiService();

  // Kirim OTP ke nomor telepon
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final data = {'phone': phone};
    return await _apiService.postRequest('/send-otp', data);
  }

  // Verifikasi OTP yang dikirim
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final data = {
      'phone': phone,
      'otp': otp,
    };
    return await _apiService.postRequest('/verify-otp', data);
  }
}
