import 'package:flutter/material.dart';

// Reusable top row: logo on the left, theme toggle on the right.
// Meant to be reused on Welcome, Login, and future screens.
class AppHeader extends StatelessWidget {
  final bool isDarkIcon;
  final VoidCallback onToggleTheme;

  const AppHeader({
    super.key,
    required this.isDarkIcon,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/logo.png', width: 80),
        InkWell(
          onTap: onToggleTheme,
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
        ),
      ],
    );
  }
}