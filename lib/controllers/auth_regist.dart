// ignore_for_file: avoid_print, duplicate_ignore, unnecessary_null_comparison

import 'package:ecofood/pages/reset_password.dart';
import 'package:ecofood/pages/verify.dart';
import 'package:ecofood/pages/verify_reset_pw.dart';
import 'package:ecofood/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:io'; // Import GetX package untuk snackbar

class RegisterController {
  final ApiServicereg apireg;

  // Constructor untuk menginisialisasi ApiService
  RegisterController({required this.apireg});

  bool? get isVerified => null;

// Fungsi registrasi
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    // Validasi input
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Semua kolom harus diisi!',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Format email tidak valid!',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (!RegExp(r'^[1-9]\d{9,14}$').hasMatch(phone)) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message:
            'Nomor HP tidak valid! Nomor HP harus diawali dengan kode negara tanpa simbol "+".',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (password.length < 6) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Kata sandi harus minimal 6 karakter!',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message: 'Kata sandi tidak cocok!',
        backgroundColor: Colors.red,
      );
      return;
    }

    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm_password': confirmPassword,
    };

    try {
      // Kirim data ke API
      final result = await apireg.postRequest('/auth/register', data);

      // ignore: unnecessary_null_comparison
      if (result == null) {
        _showSnackbar(
          context: context,
          title: 'Kesalahan',
          message: 'Server tidak merespons. Silakan coba lagi.',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Tangani jika akun sudah ada
      if (result.containsKey('error')) {
        if (result['error'] == 'Pengguna sudah ada') {
          if (result['is_verified'] == 0) {
            // Akun sudah ada, tetapi belum diverifikasi
            _showSnackbar(
              context: context,
              title: 'Info',
              message:
                  'Akun sudah terdaftar, tetapi belum diverifikasi. Silakan cek WhatsApp untuk kode OTP.',
              backgroundColor: Colors.orange,
            );
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Verify(phone: phone)),
              );
            }
          } else {
            // Akun sudah diverifikasi
            _showSnackbar(
              context: context,
              title: 'Info',
              message: 'Akun sudah terverifikasi. Silakan login.',
              backgroundColor: Colors.blue,
            );
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          }
        } else {
          // Kesalahan lainnya
          _showSnackbar(
            context: context,
            title: 'Kesalahan',
            message: 'Kesalahan: ${result['error']}',
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Registrasi berhasil
        _showSnackbar(
          context: context,
          title: 'Sukses',
          message: 'Registrasi berhasil! Anda bisa verifikasi OTP sekarang.',
          backgroundColor: Colors.green,
        );
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Verify(phone: phone)),
          );
        }
      }
    } catch (e) {
      // Tangani kesalahan
      _showSnackbar(
        context: context,
        title: 'Kesalahan',
        message:
            'Data yang Anda masukkan tidak valid atau terjadi kesalahan: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> verifyOtpForRegistration({
    required String otp,
    required String phone,
    required BuildContext context,
  }) async {
    final data = {'otp': otp, 'phone': phone};

    try {
      // Mengirim request untuk verifikasi OTP
      final result = await apireg.postRequest('/otp/verify', data);

      // Menangani hasil dari API
      if (result['error'] != null) {
        _showSnackbar(
          context: context,
          title: 'Error',
          message: 'Error: ${result['error']}',
          backgroundColor: Colors.red,
        );
        return;
      }

      if (result['message'] == 'Account verified successfully') {
        _showSnackbar(
          context: context,
          title: 'Sukses',
          message: 'OTP berhasil diverifikasi! Anda bisa login sekarang.',
          backgroundColor: Colors.green,
        );
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        _showSnackbar(
          context: context,
          title: 'Error',
          message: 'OTP tidak valid atau sudah kadaluarsa.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Menangani error jika terjadi masalah saat request
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
      );
    }
  } // Fungsi untuk menampilkan snackbar

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
}
