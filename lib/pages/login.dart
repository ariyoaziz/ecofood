import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:otp_login/controllers/login_controller.dart';
import 'package:otp_login/pages/forget_password.dart';
import 'package:otp_login/pages/register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
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
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF00712D),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hello there, sign in to continue',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0XFF00712D),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Input untuk Email atau Phone
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  child: TextField(
                    controller: loginController.emailOrPhoneController,
                    decoration: InputDecoration(
                      labelText: 'Email or Phone',
                      hintText: 'Input email or phone',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0XFF00712D), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Input untuk Password
                Obx(() => SizedBox(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      child: TextField(
                        controller: loginController.passwordController,
                        obscureText: !loginController.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Input your password',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0XFF00712D), width: 2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              loginController.isPasswordVisible.value =
                                  !loginController.isPasswordVisible.value;
                            },
                          ),
                        ),
                      ),
                    )),

                // Tautan "Forget Password"
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(const ForgetPassword()),
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0XFF00712D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Tombol Login
                SizedBox(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () => loginController.login(),
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
                SizedBox(height: screenHeight * 0.03),

                // Teks "Don't have an account? Sign Up"
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color(0XFF00712D),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(const Register());
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
    );
  }
}
