import 'package:flutter/material.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/pages/verify.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Don't worry! Just enter your phone below, and we'll send you a link to reset your password.",
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
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Input phone',
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
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Verify(),
                        ),
                        (route) => false,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF00712D),
                        foregroundColor: const Color(0XFFFFFBE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Send Reset',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth * 0.035,
                        color: const Color(0XFF00712D),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
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
}
