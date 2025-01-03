// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:ecofood/services/api_service.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileController {
  final ApiService apiService;

  ProfileController({required this.apiService});
  Future<String> getProfilehome({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String emailOrPhone = prefs.getString('user_email_or_phone') ?? '';

      if (emailOrPhone.isEmpty) {
        throw Exception('Email or phone not found in SharedPreferences');
      }

      final result = await apiService
          .getRequest('/profile/profile?email_or_phone=$emailOrPhone');
      final Map<String, dynamic> data = result as Map<String, dynamic>;

      // Pastikan data yang Anda dapatkan berisi nama
      return data['name'] ?? 'No name found';
    } catch (e) {
      throw Exception('Error fetching profile data: $e');
    }
  }

  Future<void> getProfileData({required BuildContext context}) async {
    try {
      // Ambil data email atau phone dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? emailOrPhone = prefs.getString('user_email_or_phone');

      debugPrint('emailOrPhone dari SharedPreferences: $emailOrPhone');

      // Jika emailOrPhone tidak ada, berarti user belum login
      if (emailOrPhone == null) {
        _tampilkanSnackbar(
          context: context,
          judul: 'Kesalahan',
          pesan: 'Anda belum login. Harap login terlebih dahulu.',
          warnaLatar: Colors.red,
        );
        return;
      }

      debugPrint(
          'Memanggil API untuk mendapatkan profil dengan emailOrPhone: $emailOrPhone');

      // Menampilkan indikator loading
      _tampilkanLoading(context, true);

      // Melakukan pemanggilan API
      final hasil = await apiService
          .getRequest('/profile/profile?email_or_phone=$emailOrPhone');

      // Log respons untuk debugging
      debugPrint('Raw Response: $hasil');

      // Parsing JSON langsung tanpa normalisasi
      final Map<String, dynamic> data = hasil as Map<String, dynamic>;

      // Validasi keberadaan data
      if (!data.containsKey('name')) {
        _tampilkanSnackbar(
          context: context,
          judul: 'Kesalahan',
          pesan: 'Data profil tidak ditemukan.',
          warnaLatar: Colors.red,
        );
        _tampilkanLoading(context, false);
      }

      // Ambil nama pengguna dan data lainnya
      final String name = data['name'] ?? 'Tidak Diketahui';
      final String email = data['email'] ?? 'Tidak Diketahui';
      final String phone = data['phone'] ?? 'Tidak Diketahui';

      // Simpan data ke SharedPreferences
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
      await prefs.setString('user_phone', phone);

      // Menampilkan notifikasi sukses
      _tampilkanSnackbar(
        context: context,
        judul: 'Sukses',
        pesan: 'Data profil berhasil dimuat!',
        warnaLatar: Colors.green,
      );

      _tampilkanLoading(context, false);
    } catch (e) {
      // Tangani error umum
      _tampilkanLoading(context, false);
      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Terjadi kesalahan saat memuat data. Silakan coba lagi nanti.',
        warnaLatar: Colors.red,
      );
      debugPrint('Error: $e');
    }
  }

  // Fungsi untuk memperbarui data profil
  Future<void> updateProfileData({
    required String name,
    required String email,
    required String phone,
    required BuildContext context,
  }) async {
    // Validasi input
    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Semua kolom harus diisi!',
        warnaLatar: Colors.red,
      );
      return;
    }

    // Validasi format email
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Format email tidak valid!',
        warnaLatar: Colors.red,
      );
      return;
    }

    // Validasi format nomor HP
    if (!RegExp(r'^[1-9]\d{9,14}$').hasMatch(phone)) {
      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Nomor HP tidak valid!',
        warnaLatar: Colors.red,
      );
      return;
    }

    // Mengambil email atau phone dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailOrPhone =
        prefs.getString('user_email_or_phone'); // Ambil email atau phone

    if (emailOrPhone == null) {
      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Anda belum login. Harap login terlebih dahulu.',
        warnaLatar: Colors.red,
      );
      return;
    }

    // Menampilkan indikator loading
    _tampilkanLoading(context, true);

    final data = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    try {
      // Kirim permintaan PUT ke API menggunakan email atau phone
      final hasil = await apiService.putRequest(
          '/profile/$emailOrPhone', data); // Menggunakan email atau phone

      // Menutup indikator loading setelah permintaan selesai
      _tampilkanLoading(context, false);

      // Cek apakah berhasil diperbarui
      if (hasil.containsKey('success')) {
        _tampilkanSnackbar(
          context: context,
          judul: 'Sukses',
          pesan: 'Profil berhasil diperbarui!',
          warnaLatar: Colors.green,
        );
      } else {
        _tampilkanSnackbar(
          context: context,
          judul: 'Kesalahan',
          pesan: 'Gagal memperbarui profil: ${hasil['error']}',
          warnaLatar: Colors.red,
        );
      }
    } catch (e) {
      // Menutup indikator loading jika terjadi kesalahan
      _tampilkanLoading(context, false);

      _tampilkanSnackbar(
        context: context,
        judul: 'Kesalahan',
        pesan: 'Terjadi kesalahan saat memperbarui data: $e',
        warnaLatar: Colors.red,
      );
    }
  }

  void _tampilkanSnackbar({
    required BuildContext context,
    required String judul,
    required String pesan,
    required Color warnaLatar,
    SnackPosition snackPosition = SnackPosition.TOP, // Default posisi snack bar
    int durationInSeconds = 3, // Default durasi tampil snack bar
  }) {
    final snackBar = SnackBar(
      content: Text(
        '$judul\n$pesan',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: warnaLatar,
      duration: Duration(seconds: durationInSeconds), // Menambahkan durasi
      behavior: snackPosition == SnackPosition.TOP
          ? SnackBarBehavior.floating
          : SnackBarBehavior.fixed, // Menentukan posisi SnackBar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Fungsi untuk menampilkan indikator loading
  void _tampilkanLoading(BuildContext context, bool isLoading) {
    if (isLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
    } else {
      Navigator.pop(context); // Menutup loading dialog
    }
  }
}
