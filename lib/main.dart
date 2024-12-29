import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecofood/pages/splash_screen.dart';
import 'package:ecofood/pages/get_started.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/pages/home.dart';
import 'package:ecofood/bindings/login_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch whether it's the first launch
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // If it's the first launch, set the value to false so it doesn't show the 'get_started' screen next time
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  // Run the app and pass the value of isFirstLaunch to MyApp
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Set initial route to splash screen
      getPages: [
        GetPage(
            name: '/splash',
            page: () => const SplashScreen()), // Splash Screen route
        GetPage(
            name: '/get_started',
            page: () => const GetStarted()), // Get Started route
        GetPage(
            name: '/login',
            page: () => const Login(),
            binding: LoginBinding()), // Login route
        GetPage(
            name: '/home', page: () => const MyHomePage()), // Home page route
      ],
    );
  }
}
