import 'package:ecofood/bindings/ForgetPasswordBinding.dart';
import 'package:ecofood/bindings/registrasi_binding.dart';
import 'package:ecofood/pages/Profile.dart';
import 'package:ecofood/pages/forget_password.dart';
import 'package:ecofood/pages/reset_password.dart';
import 'package:ecofood/pages/verify_reset_pw.dart'; // Import halaman verify reset password
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecofood/pages/splash_screen.dart';
import 'package:ecofood/pages/get_started.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/pages/register.dart'; // Halaman Registrasi
import 'package:ecofood/pages/verify.dart'; // Halaman Verifikasi OTP
import 'package:ecofood/pages/home.dart';
import 'package:ecofood/bindings/login_binding.dart'; // Import login binding
import 'package:ecofood/services/api_service.dart'; // Import ApiService
import 'package:ecofood/controllers/auth_controller.dart'; // Import AuthController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ambil nilai apakah ini adalah peluncuran pertama kali
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // Jika ini adalah peluncuran pertama kali, set nilai menjadi false
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  // Inisialisasi service dan controller
  final apiService = ApiService();
  Get.put(apiService);
  Get.put(AuthController(apiService: apiService));

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Navigasi awal
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
        ), // Splash Screen route
        GetPage(
          name: '/get_started',
          page: () => const GetStarted(),
        ), // Get Started route
        GetPage(
          name: '/login',
          page: () => const Login(),
          binding: LoginBinding(), // Binding untuk login
        ),
        GetPage(
          name: '/register',
          page: () => const Register(),
          binding: RegisterBinding(), // Binding untuk registrasi
        ),
        GetPage(
          name: '/verify',
          page: () => const Verify(phone: ''), // Halaman verifikasi OTP
        ),
        GetPage(
          name: '/forget-password',
          page: () => const ForgetPassword(),
          binding: ForgetPasswordBinding(), // Binding untuk ForgetPassword
        ),
        GetPage(
          name: '/verify-reset',
          page: () => const VerifyResetPw(
              phone: ''), // Halaman verifikasi reset password
          binding: ForgetPasswordBinding(),
        ),
        GetPage(
          name: '/reset-password',
          page: () => const ResetPassword(), // Halaman reset password
          binding: ForgetPasswordBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const MyHomePage(),
        ), // Halaman utama
        GetPage(
          name: '/profile',
          page: () => Profile(), // Halaman profile
        ),
      ],
    );
  }
}
