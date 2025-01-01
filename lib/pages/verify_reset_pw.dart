import 'package:flutter/material.dart';
import 'package:ecofood/services/api_service.dart';
import 'package:get/get.dart';
import 'package:ecofood/controllers/auth_controller.dart'; // Import AuthController

class VerifyResetPw extends StatefulWidget {
  final String phone;

  const VerifyResetPw({super.key, required this.phone});

  @override
  State<VerifyResetPw> createState() => _VerifyResetPwState();
}

class _VerifyResetPwState extends State<VerifyResetPw> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  // Mengambil instance AuthController yang sudah ada
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Image.asset(
                    'assets/images/verify.png',
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Verifikasi Nomor Telepon Anda',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Masukkan kode yang telah kami kirimkan ke nomor',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.03,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      widget.phone,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xFF00712D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _otpTextField(controller1),
                      SizedBox(width: screenWidth * 0.02),
                      _otpTextField(controller2),
                      SizedBox(width: screenWidth * 0.02),
                      _otpTextField(controller3),
                      SizedBox(width: screenWidth * 0.02),
                      _otpTextField(controller4),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Menggabungkan nilai controller untuk OTP
                        String otp = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text;

                        // Validasi jika OTP terdiri dari 4 digit
                        if (otp.length != 4 ||
                            otp.contains(RegExp(r'[^0-9]'))) {
                          Get.snackbar(
                            "Error",
                            "Kode OTP harus terdiri dari 4 digit angka.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return; // Hentikan jika OTP tidak valid
                        }

                        // Menampilkan dialog loading
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Mencegah dismiss saat loading
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        try {
                          // Panggil fungsi konfirmasi OTP
                          await authController.confirmOtpForPasswordReset(
                            otp: otp,
                            context: context,
                          );
                        } catch (e) {
                          // Jika ada error, tampilkan error message
                          Get.snackbar(
                            "Error",
                            "Terjadi kesalahan saat memverifikasi OTP: $e",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } finally {
                          // Menutup dialog loading setelah proses selesai
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF00712D),
                        foregroundColor: const Color(0XFFFFFBE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Konfirmasi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _otpTextField(TextEditingController controller) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.12,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context)
                .nextFocus(); // Move to next field automatically
          } else if (value.isEmpty) {
            FocusScope.of(context)
                .previousFocus(); // Move to previous field automatically
          }
        },
      ),
    );
  }
}
