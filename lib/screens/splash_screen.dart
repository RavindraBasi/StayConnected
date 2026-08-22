import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Placeholder only for now — real theme switching arrives in Milestone 2.
  bool _isDarkIcon = false;

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
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  void _toggleIcon() {
    setState(() => _isDarkIcon = !_isDarkIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFB),
      body: SafeArea(
        child: Stack(
          children: [
            // Theme toggle icon — top right
            Positioned(
              top: 12,
              right: 12,
              child: _ThemeToggleButton(
                isDarkIcon: _isDarkIcon,
                onTap: _toggleIcon,
              ),
            ),

            // Logo + About link — centered
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to AboutScreen (Milestone 3)
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'About StayConnected',
                          style: TextStyle(
                            color: Color(0xFF5C6B70),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Color(0xFF5C6B70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Small reusable circular button for the theme toggle icon.
class _ThemeToggleButton extends StatelessWidget {
  final bool isDarkIcon;
  final VoidCallback onTap;

  const _ThemeToggleButton({
    required this.isDarkIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isDarkIcon ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}