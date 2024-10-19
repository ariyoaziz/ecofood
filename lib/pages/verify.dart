import 'package:flutter/material.dart';
import 'package:otp_login/pages/home.dart';
import 'dart:async';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  int countdownSeconds = 30; // Durasi countdown dalam detik
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
    timer.cancel(); // Menghentikan timer saat widget dibuang
    super.dispose();
  }

  String formatCountdown(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/verify.png',
                ),
                const SizedBox(height: 50),
                const Text(
                  'Verify Your Phone Number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                const SizedBox(height: 17),
                const Text(
                  'Verify with the code just now we have sent',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 17),
                Text(
                  'enter the code before  ${formatCountdown(countdownSeconds)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () {
                    // Aksi saat "Resend" di-tap
                    if (countdownSeconds == 0) {
                      // Reset countdown dan mulai lagi
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
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      String otp = controller1.text +
                          controller2.text +
                          controller3.text +
                          controller4.text;
                      ("OTP entered: $otp");
                      // Navigasi ke halaman home setelah mengklik Confirm
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(), // Ganti dengan nama halaman home
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00712D),
                      foregroundColor: const Color(0XFFFFFBE6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpTextField(TextEditingController controller) {
    return SizedBox(
      width: 50, // Lebar input
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1, // Hanya 1 karakter
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          // Pindah fokus ke TextField berikutnya
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
