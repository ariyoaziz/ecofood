import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:otp_login/pages/login.dart';
import 'package:otp_login/controllers/register_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late RegisterController registerController; // Declare the controller
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    registerController =
        Get.put(RegisterController()); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF00712D),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello there, sign up to continue',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0XFF00712D),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Input field for Name
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: TextEditingController(
                          text: registerController.nama.value),
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
                      onChanged: (value) => registerController.nama.value =
                          value, // Update the controller
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Input field for Email
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: TextEditingController(
                          text: registerController.email.value),
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
                      onChanged: (value) => registerController.email.value =
                          value, // Update the controller
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Input field for Phone
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: TextEditingController(
                          text: registerController.phone.value),
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
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => registerController.phone.value =
                          value, // Update the controller
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Input field for Password
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: TextEditingController(
                          text: registerController.pass.value),
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
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) => registerController.pass.value =
                          value, // Update the controller
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Input field for Confirm Password
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0XFF00712D), width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Register Button
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        if (registerController.pass.value ==
                            _confirmPasswordController.text) {
                          // Call register method from the controller if passwords match
                          registerController.register();
                        } else {
                          // Show error message if passwords do not match
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords do not match')),
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
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  // "I have an account? Sign In"
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
}
