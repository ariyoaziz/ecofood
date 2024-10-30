import 'package:flutter/material.dart';
import 'package:otp_login/pages/login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isPasswordVisible = false;

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
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Image.asset(
                    'assets/images/forget_password_new.png',
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.045,
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
                      fontWeight: FontWeight.normal,
                      color: const Color(0XFF1C1C1C),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your new password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFF00712D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your new password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFF00712D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
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
                        'Reset Password',
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
}
