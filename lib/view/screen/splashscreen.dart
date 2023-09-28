import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voucherin/view/Theme/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: const Center(
        child: Image(
          image: AssetImage('assets/splashscreen.png'),
          height: 400,
        ),
      ),
    );
  }
}
