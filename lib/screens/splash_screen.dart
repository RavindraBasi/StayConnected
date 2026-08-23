import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const SplashScreen({super.key, required this.onToggleTheme});

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
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WelcomeScreen(onToggleTheme: widget.onToggleTheme),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/images/logo.png', width: 300),
        ),
      ),
    );
  }
}
