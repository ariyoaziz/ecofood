import 'package:ecofood/pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecofood/controllers/auth_controller.dart'; // Import controller
import 'package:ecofood/pages/forget_password.dart';
import 'package:get/get.dart'; // Import GetX

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailAtauHpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Untuk atur visibilitas password
  bool _passwordTerlihat = false;

  // Ambil instance AuthController pakai Get.find()
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              // Biar layout nggak ketutupan
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul
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

                  // Deskripsi
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hai, masuk dulu yuk!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0XFF00712D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),

                  // TextField Email atau HP
                  _buildTextField(
                    controller: _emailAtauHpController,
                    label: 'Email atau Nomor HP',
                    hint: 'Masukkan email atau nomor HP',
                    icon: Icons.person,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 17),

                  // TextField Password
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Kata Sandi',
                    hint: 'Masukkan kata sandi',
                    icon: Icons.lock,
                    obscureText: !_passwordTerlihat,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordTerlihat
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordTerlihat = !_passwordTerlihat;
                        });
                      },
                    ),
                  ),

                  // Tautan "Lupa Kata Sandi"
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
                      },
                      child: const Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          color: Color(0XFF00712D),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Tombol Login
                  _buildButton(
                    text: 'Masuk',
                    onPressed: () async {
                      String emailAtauHp = _emailAtauHpController.text;
                      String password = _passwordController.text;

                      await _authController.login(
                        emailOrPhone: emailAtauHp,
                        password: password,
                        context: context,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Teks "Belum punya akun? Daftar"
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black, // Warna teks umum
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        const TextSpan(text: 'Belum punya akun? '),
                        TextSpan(
                          text: 'Daftar',
                          style: const TextStyle(
                            color: Color(0XFF00712D), // Warna teks "Daftar"
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

  // Fungsi untuk membuat TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      width: double.infinity, // Sesuaikan lebar layar
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF00712D), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol
  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 50,
      width: double.infinity, // Sesuaikan lebar layar
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF00712D),
          foregroundColor: const Color(0XFFFFFBE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
