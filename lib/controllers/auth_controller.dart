// ignore_for_file: avoid_print, duplicate_ignore, unnecessary_null_comparison

import 'package:ecofood/pages/reset_password.dart';
import 'package:ecofood/pages/verify.dart';
import 'package:flutter/material.dart';
import 'package:ecofood/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:io';

class AuthController {
  final ApiService apiService;

  // Constructor untuk menginisialisasi ApiService
  AuthController({required this.apiService});

  bool? get isVerified => null;

// Metode untuk menangani error login
  void _handleLoginError(Map<String, dynamic> result, BuildContext context) {
    String errorMessage;

    switch (result['error']) {
      case 'Invalid credentials':
        errorMessage = 'Email/No HP atau password Anda salah. Coba lagi!';
        break;
      case 'User not found':
        errorMessage =
            'Akun dengan email/No HP ini tidak ditemukan. Daftar terlebih dahulu!';
        break;
      case 'Account not verified':
        errorMessage =
            'Akun Anda belum diverifikasi. Silakan cek email atau WhatsApp untuk kode verifikasi.';
        break;
      default:
        errorMessage = 'Terjadi kesalahan: ${result['error']}';
    }

    _showSnackbar(
        context: context,
        title: 'Error',
        message: errorMessage,
        backgroundColor: Colors.red);
  }

  // Metode untuk menyimpan data pengguna di SharedPreferences
  Future<void> _saveUserData(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email_or_phone',
        user['email'] ?? user['phone']); // Menyimpan email atau phone
  }

  // Fungsi untuk login
  Future<void> login({
    required String emailOrPhone,
    required String password,
    required BuildContext context,
  }) async {
    if (emailOrPhone.isEmpty || password.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Email/Phone dan password tidak boleh kosong!',
        backgroundColor: Colors.red,
      );
      return;
    }

    final data = {
      'email_or_phone': emailOrPhone,
      'password': password,
    };

    try {
      final result = await apiService.postRequest('/auth/login', data);

      if (result == null) {
        _showSnackbar(
          context: context,
          title: 'Error',
          message: 'Terjadi kesalahan dalam respons API.',
          backgroundColor: Colors.red,
        );
        return;
      }

      if (result.containsKey('error')) {
        _handleLoginError(result, context);
        return;
      }

      var user = result['user'];

      if (user == null) {
        _showSnackbar(
          context: context,
          title: 'Error',
          message: 'Data pengguna tidak ditemukan.',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Menyimpan data pengguna
      await _saveUserData(user);

      _showSnackbar(
        context: context,
        title: 'Sukses',
        message: 'Login berhasil!',
        backgroundColor: Colors.green,
      );

      // Pindah ke halaman home setelah login sukses
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Terjadi kesalahan saat memproses permintaan: $e',
        backgroundColor: Colors.red,
      );
    }
  }

// Fungsi untuk request reset password
  Future<bool> requestPasswordReset({
    required String phone,
    required BuildContext context,
  }) async {
    if (phone.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Nomor telepon tidak boleh kosong!',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Validasi format nomor telepon
    if (!RegExp(r'^[1-9]\d{9,14}$').hasMatch(phone)) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message:
            'Nomor telepon tidak valid! Nomor telepon harus diawali dengan kode negara tanpa simbol "+" dan memiliki panjang antara 10 hingga 15 angka.',
        backgroundColor: Colors.red,
      );
      return false;
    }

    final data = {
      'phone':
          phone.replaceAll(RegExp(r'\D'), '') // Menghapus karakter selain angka
    };

    try {
      final result =
          await apiService.postRequest('/auth/request-password-reset', data);

      // Debugging log
      print('Response from reset request: $result');

      if (result['message'] == 'OTP sent for password reset') {
        _showSnackbar(
          context: context,
          title: 'Sukses',
          message: 'OTP telah dikirim ke ponsel Anda untuk reset password.',
          backgroundColor: Colors.green,
        );

        // Simpan nomor telepon di SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', phone); // Simpan nomor telepon

        Get.offAllNamed('/verify-reset'); // Navigasi menggunakan GetX
        return true;
      } else {
        String errorMessage = result['error'] ?? 'Terjadi kesalahan.';
        _showSnackbar(
          context: context,
          title: 'Kesalahan',
          message: errorMessage,
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (e) {
      // Tangani exception yang ada
      print('Error: $e');
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Terjadi kesalahan saat memproses permintaan Anda.',
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

// Fungsi untuk mengonfirmasi OTP untuk reset password
  Future<void> confirmOtpForPasswordReset({
    required String otp,
    required BuildContext context,
  }) async {
    if (otp.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'OTP tidak boleh kosong!',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Ambil nomor telepon dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone') ?? '';

    if (phone.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Nomor telepon tidak ditemukan!',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Menyiapkan data untuk dikirim
    final data = {'otp': otp, 'phone': phone};

    try {
      final result = await apiService.postRequest('/auth/confirm-otp', data);

      if (result != null && result['message'] == 'OTP verified successfully') {
        // Simpan OTP yang telah diverifikasi di SharedPreferences
        await prefs.setString(
            'otp', otp); // Menyimpan OTP yang berhasil diverifikasi

        _showSnackbar(
          context: context,
          title: 'Sukses',
          message:
              'OTP berhasil diverifikasi. Anda bisa melanjutkan reset password.',
          backgroundColor: Colors.green,
        );

        // Pastikan context masih terpasang sebelum navigasi
        if (context.mounted) {
          // Delay sebelum navigasi untuk memberi waktu bagi snackbar untuk selesai
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              Get.offAllNamed('/reset-password');
            }
          });
        }
      } else {
        String errorMessage = result['error'] ?? 'OTP tidak valid.';
        _showSnackbar(
          context: context,
          title: 'Error',
          message: errorMessage,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    // Validasi input
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Kata sandi tidak boleh kosong!',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Kata sandi tidak cocok!',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Ambil nomor telepon dan OTP
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone') ?? '';
    final otp = prefs.getString('otp') ?? '';

    if (phone.isEmpty || otp.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Nomor telepon atau OTP tidak ditemukan!',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Menyiapkan data JSON
    final data = {
      'phone': phone,
      'otp': otp,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };

    try {
      final result = await apiService.postRequest('/auth/reset-password', data);
      print('Full API Response: $result');

      if (result['message'] != null &&
          result['message'] == 'Password reset successfully') {
        _showSnackbar(
          context: context,
          title: 'Sukses',
          message: result['message'],
          backgroundColor: Colors.green,
        );

        // Navigasi ke halaman login
        print('Navigating to login...');
        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/login');
        });
        print('Navigation triggered.');
      } else {
        print('API Error: ${result['message']}');
        _showSnackbar(
          context: context,
          title: 'Error',
          message: result['message'] ?? 'Terjadi kesalahan.',
          backgroundColor: Colors.red,
        );
      }
    } on SocketException {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Tidak ada koneksi internet.',
        backgroundColor: Colors.red,
      );
    } catch (e) {
      print('Unexpected Error: $e');
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
      );
    }
  }

// Fungsi untuk menampilkan snackbar
  void _showSnackbar({
    required BuildContext context,
    required String title,
    required String message,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
    SnackPosition snackPosition = SnackPosition.TOP,
    int durationInSeconds = 3,
  }) {
    // Menggunakan Get.snackbar untuk tampilan snackbar
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      // ignore: deprecated_member_use
      backgroundColor: backgroundColor.withOpacity(0.9),
      colorText: textColor,
      borderRadius: 15,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      duration: Duration(seconds: durationInSeconds),
      animationDuration: const Duration(milliseconds: 300),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      icon: Icon(Icons.info, color: textColor),
      shouldIconPulse: false,
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
        ),
      ),
    );
  }

  register(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required BuildContext context}) {}
}
