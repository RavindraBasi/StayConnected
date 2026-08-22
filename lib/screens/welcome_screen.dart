import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Placeholder only — real app-wide theme wiring comes separately.
  bool _isDarkIcon = false;

  void _toggleTheme() {
    setState(() => _isDarkIcon = !_isDarkIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Logo left, theme toggle right
              AppHeader(
                isDarkIcon: _isDarkIcon,
                onToggleTheme: _toggleTheme,
              ),

              const Spacer(),

              // Simple illustration using icons (no CustomPainter)
              const _SafetyIllustration(),

              const SizedBox(height: 32),

              const Text(
                'Stay Connected When\nIt Matters Most',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF161B1D),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Get your trusted contacts notified\nbefore your phone goes offline.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5C6B70),
                ),
              ),

              const SizedBox(height: 16),

              // About + How it works — both are links to the About screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to AboutScreen (Milestone 3)
                    },
                    child: const Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFF1D6FA5),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('•', style: TextStyle(color: Color(0xFF5C6B70))),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to AboutScreen, "how it works" section
                    },
                    child: const Text(
                      'How it works',
                      style: TextStyle(
                        color: Color(0xFF1D6FA5),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(active: true),
                  _buildDot(active: false),
                  _buildDot(active: false),
                ],
              ),

              const SizedBox(height: 24),

              // Get Started CTA — now the single way forward from this screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: navigate to Login/Register (Milestone 5)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D6FA5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Get Started →',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot({required bool active}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1D6FA5) : const Color(0xFFEAF4F2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// Simple safety-concept illustration built from icons — no CustomPainter.
class _SafetyIllustration extends StatelessWidget {
  const _SafetyIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4F2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.phonelink_ring,
        size: 72,
        color: Color(0xFF2E9E6D),
      ),
    );
  }
}