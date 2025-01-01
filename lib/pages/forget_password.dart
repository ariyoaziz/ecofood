// ignore_for_file: avoid_print

import 'package:ecofood/pages/verify_reset_pw.dart';
import 'package:ecofood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get_core/src/get_main.dart'; // Import halaman Verifikasi OTP

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthController _authController =
      AuthController(apiService: ApiService()); // Inisialisasi AuthController

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Image.asset(
                    'assets/images/forget_password_input.png',
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Santai aja! Masukin nomor HP kamu di bawah ini, nanti kami kirim Kode OTP buat reset kata sandi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.035,
                      color: const Color(0XFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Nomor HP',
                        hintText: 'Masukkan nomor HP kamu',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildButton(
                    text: 'Kirim Kode Reset',
                    onPressed: () async {
                      String phone = _phoneController.text;
                      if (phone.isNotEmpty) {
                        print("Nomor HP yang dimasukkan: $phone");
                        bool result =
                            await _authController.requestPasswordReset(
                          phone: phone,
                          context: context,
                        );

                        if (result) {
                          print("Navigasi ke halaman verifikasi...");
                          // Gunakan Get.to() untuk navigasi
                          Get.to(
                            VerifyResetPw(phone: phone),
                            transition: Transition.fadeIn,
                          );
                        } else {
                          print("Gagal mengirim permintaan reset kata sandi.");
                        }
                      } else {
                        print("Nomor HP kosong.");
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        const TextSpan(text: "Sudah ingat kata sandi? "),
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Color(0XFF00712D),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed('/login');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF00712D),
          foregroundColor: const Color(0XFFFFFBE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
