import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ecofood/pages/home.dart';
import 'package:ecofood/pages/register.dart';
import 'package:ecofood/pages/forget_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Untuk mengontrol visibilitas password
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 50),

                // Teks rata kiri
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '      Hello there, sigin to continue',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0XFF00712D),
                    ),
                  ),
                ),

                const SizedBox(height: 17),

                // SizedBox untuk TextField Email atau Phone
                SizedBox(
                  width: 350, // Lebar TextField
                  height: 50, // Tinggi TextField
                  child: TextField(
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
                const SizedBox(height: 17),

                // SizedBox untuk TextField Password
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    obscureText: !_isPasswordVisible,
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isPasswordVisible =
                                  !_isPasswordVisible; // Toggle visibilitas
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Tautan "Forget Password"
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                        (route) => false,
                      );
                      ("Sign Up pressed");
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0XFF00712D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Tombol Login
                SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                        (route) => false),
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
                const SizedBox(height: 20),

                // Teks "Don't have an account? Sign Up"
                const SizedBox(height: 20),

                // Teks "Don't have an account? Sign Up"
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color:
                          Colors.black, // Warna untuk "Don't have an account?"
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color(0XFF00712D), // Warna untuk "Sign Up"
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline, // Garis bawah
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                              (route) => false,
                            );
                            ("Sign Up pressed");
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
