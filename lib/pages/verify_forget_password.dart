import 'package:flutter/material.dart';
import 'package:otp_login/pages/reset_password.dart';
import 'dart:async';

class VerifyForgetPassword extends StatefulWidget {
  const VerifyForgetPassword({super.key});

  @override
  State<VerifyForgetPassword> createState() => _VerifyForgetPasswordState();
}

class _VerifyForgetPasswordState extends State<VerifyForgetPassword> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  int countdownSeconds = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countdownSeconds > 0) {
        setState(() {
          countdownSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  String formatCountdown(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

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
              padding: EdgeInsets.all(screenWidth * 0.05),
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
                    'Verify Your Phone Number',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Verify with the code just now we have sent',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF1C1C1C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _otpTextField(controller1),
                      const SizedBox(width: 8),
                      _otpTextField(controller2),
                      const SizedBox(width: 8),
                      _otpTextField(controller3),
                      const SizedBox(width: 8),
                      _otpTextField(controller4),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Enter the code before ${formatCountdown(countdownSeconds)}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      if (countdownSeconds == 0) {
                        setState(() {
                          countdownSeconds = 30;
                        });
                        startTimer();
                      }
                    },
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        color: Color(0XFF00712D),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        String otp = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text;

                        if (otp == "") {
                          // dengan OTP yang sesuai
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("OTP salah, coba lagi")),
                          );
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
                        'Confirm',
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
    return SizedBox(
      width: 50,
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
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
