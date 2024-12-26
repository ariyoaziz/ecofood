import 'package:flutter/material.dart';
import 'package:ecofood/pages/login.dart';
import 'package:ecofood/pages/register.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFfff),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/get_started2.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 45),

                // Teks 'Welcome'
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF00712D),
                  ),
                ),
                const SizedBox(height: 10),

                // Teks 'Fuel Your Body with'
                const Text(
                  'Fuel Your Body with',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0XFF00712D),
                  ),
                ),
                const SizedBox(height: 5),

                // Teks RichText 'ecofood'
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'eco',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0Xff534339),
                        ),
                      ),
                      TextSpan(
                        text: 'food',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF00712D),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),

                // Tombol 'Login'
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
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
                const SizedBox(height: 17),

                // Tombol 'Create an Account'
                SizedBox(
                  height: 50,
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                        (route) => false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0XFF00712D),
                        width: 2,
                      ),
                      foregroundColor: const Color(0XFF00712D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Create an Account',
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
    );
  }
}
