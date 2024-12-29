import 'package:flutter/material.dart';
import 'package:ecofood/controllers/auth_controller.dart';
import 'package:ecofood/pages/verify.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthController _authController = AuthController();
  bool _isPasswordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '     Hello there, sign in to continue',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0XFF00712D)),
                    ),
                  ),
                  const SizedBox(height: 17),
                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Input name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 17),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Input email',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 17),
                  _buildTextField(
                    controller: _phoneController,
                    labelText: 'Phone',
                    hintText: 'Input phone',
                    icon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 17),
                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Input password',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 17),
                  _buildTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter password',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () => _authController.registerUser(
                        context,
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
    bool isPassword = false,
  }) {
    return SizedBox(
      width: 350,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
