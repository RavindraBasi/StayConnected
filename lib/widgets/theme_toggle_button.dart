import 'package:flutter/material.dart';

// Standalone circular theme toggle — reusable anywhere, no logo attached.
class ThemeToggleButton extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const ThemeToggleButton({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onToggleTheme,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.12),
          shape: BoxShape.circle,
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.45),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Icon(
          isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}