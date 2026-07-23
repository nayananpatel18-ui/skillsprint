import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [

              Color(0xFF1565C0),

              Color(0xFF42A5F5),

            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

          ),

        ),

        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(

                Icons.school,

                color: Colors.white,

                size: 90,

              ),

              const SizedBox(height: 20),

              const Text(

                "SkillSprint",

                style: TextStyle(

                  fontSize: 34,

                  color: Colors.white,

                  fontWeight: FontWeight.bold,

                ),

              ),

              const SizedBox(height: 10),

              const Text(

                "Track Skills\nBuild Habits\nBecome Better",

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 18,

                  color: Colors.white70,

                ),

              ),

              const SizedBox(height: 40),

              const CircularProgressIndicator(

                color: Colors.white,

              ),

            ],

          ),

        ),

      ),

    );

  }

}