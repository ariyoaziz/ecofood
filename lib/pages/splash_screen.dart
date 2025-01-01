import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'dart:async'; // Import untuk Future.delayed
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;

  @override
  void initState() {
    super.initState();

    // Delay untuk animasi fade-in logo
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        visible = true;
      });
    });

    // Panggil fungsi _navigate untuk memeriksa apakah aplikasi pertama kali diluncurkan
    _navigate();
  }

  // Fungsi untuk menunggu dan memeriksa apakah aplikasi pertama kali diluncurkan
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3)); // Tunggu selama 3 detik

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // Jika pertama kali, arahkan ke halaman 'get_started'
      await prefs.setBool('isFirstLaunch',
          false); // Setel 'isFirstLaunch' menjadi false setelah peluncuran pertama
      Get.offNamed('/get_started');
    } else {
      // Jika sudah login sebelumnya, arahkan ke halaman 'login'
      Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0, // Fade-in animasi
          duration: const Duration(milliseconds: 1500),
          child: Image.asset(
            'assets/images/logo.png', // Gantilah dengan path logo Anda
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
