import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_login/pages/login.dart';
import 'package:otp_login/pages/register.dart';
import 'package:otp_login/bindings/login_binding.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/get_started2.png',
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.6,
                ),
                SizedBox(height: screenHeight * 0.05),

                // Welcome Text
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF00712D),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                const Text(
                  'Fuel Your Body with',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0XFF00712D),
                  ),
                ),
                const SizedBox(height: 5),

                // RichText for 'ecofood'
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'eco',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0Xff534339),
                        ),
                      ),
                      TextSpan(
                        text: 'food',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF00712D),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Login Button
                SizedBox(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ensure the LoginBinding is called when navigating
                      Get.offAll(() => const Login(), binding: LoginBinding());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00712D),
                      foregroundColor: const Color(0XFFFFFBE6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Create an Account Button
                SizedBox(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to Register page
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0XFF00712D),
                        width: 2,
                      ),
                      foregroundColor: const Color(0XFF00712D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
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
    );
  }
}
