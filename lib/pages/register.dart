import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/pages/verify.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF00712D),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '     Hello there, sigin to continue',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0XFF00712D)),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    width: 350, // Lebar TextField
                    height: 50, // Tinggi TextField
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Input name',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 350, // Lebar TextField
                    height: 50, // Tinggi TextField
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Input email',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 350, // Lebar TextField
                    height: 50, // Tinggi TextField
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
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Input password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
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
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Confrim password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
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
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Verify(),
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
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        const TextSpan(text: "I have an account? "),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0XFF00712D),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                                (route) => false,
                              );
                              ("Sign In pressed");
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
      ),
    );
  }
}
