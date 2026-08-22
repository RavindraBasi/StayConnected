import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToWelcomeAfterDelay();
  }

  void _goToWelcomeAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFB),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 300,
          ),
        ),
      ),
    );
  }
}