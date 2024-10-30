import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_login/bindings/login_binding.dart';
import 'package:otp_login/bindings/register_binding.dart';
import 'package:otp_login/pages/splash_screen.dart';
import 'package:otp_login/pages/get_started.dart';
import 'package:otp_login/pages/login.dart';
import 'package:otp_login/pages/register.dart';
import 'package:otp_login/pages/home.dart';
import 'package:otp_login/pages/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp({required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstLaunch ? '/splash' : '/get_started',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/get_started', page: () => const GetStarted()),
        GetPage(
            name: '/login', page: () => const Login(), binding: LoginBinding()),
        GetPage(
            name: '/register',
            page: () => const Register(),
            binding: RegisterBinding()),
        GetPage(name: '/verify', page: () => const Verify()),
        GetPage(name: '/home', page: () => const MyHomePage()),
      ],
    );
  }
}
