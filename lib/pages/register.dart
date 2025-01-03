import 'package:ecofood/pages/verify.dart';
import 'package:flutter/material.dart';
import 'package:ecofood/controllers/auth_regist.dart'; // Ganti dengan RegisterController
import 'package:ecofood/services/register_service.dart'; // Pastikan ini yang digunakan
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterController _registerController = RegisterController(
      apireg: ApiServicereg()); // Ganti ke RegisterController
  bool _isPasswordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var logger = Logger();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double lebarLayar = constraints.maxWidth;
                  double lebarForm = lebarLayar * 0.9;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selamat Datang',
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
                          'Hai, daftar dulu yuk biar bisa lanjut',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0XFF00712D),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      _buildTextField(
                        controller: _nameController,
                        labelText: 'Nama',
                        hintText: 'Masukkan nama kamu',
                        icon: Icons.person_outline,
                        width: lebarForm,
                      ),
                      const SizedBox(height: 17),
                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Masukkan email kamu',
                        icon: Icons.email_outlined,
                        width: lebarForm,
                      ),
                      const SizedBox(height: 17),
                      _buildTextField(
                        controller: _phoneController,
                        labelText: 'Nomor HP',
                        hintText: 'Masukkan nomor HP kamu',
                        icon: Icons.phone_outlined,
                        width: lebarForm,
                      ),
                      const SizedBox(height: 17),
                      _buildTextField(
                        controller: _passwordController,
                        labelText: 'Kata Sandi',
                        hintText: 'Masukkan kata sandi kamu',
                        icon: Icons.lock_outline,
                        obscureText: !_isPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        isPassword: true,
                        width: lebarForm,
                      ),
                      const SizedBox(height: 17),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Konfirmasi Kata Sandi',
                        hintText: 'Masukkan ulang kata sandi kamu',
                        icon: Icons.lock_outline,
                        obscureText: !_isPasswordVisible,
                        toggleVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        isPassword: true,
                        width: lebarForm,
                      ),
                      const SizedBox(height: 50),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(
                        height: 50,
                        width: lebarForm,
                        child: ElevatedButton(
                          onPressed: () async {
                            String nama = _nameController.text;
                            String email = _emailController.text;
                            String nomorHp = _phoneController.text;
                            String kataSandi = _passwordController.text;
                            String konfirmasiSandi =
                                _confirmPasswordController.text;

                            await _registerController.register(
                              name: nama,
                              email: email,
                              phone: nomorHp,
                              password: kataSandi,
                              confirmPassword: konfirmasiSandi,
                              context: context,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF00712D),
                            foregroundColor: const Color(0XFFFFFBE6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            const TextSpan(text: "Sudah punya akun? "),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: Color(0XFF00712D),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed('/login');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
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
    required double width,
  }) {
    return SizedBox(
      width: width,
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
