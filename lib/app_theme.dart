import 'package:flutter/material.dart';

// Central place for both light and dark theme definitions.
class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFAFBFB),
    primaryColor: const Color(0xFF1D6FA5),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1D6FA5),
      secondary: Color(0xFF2E9E6D),
      surface: Color(0xFFEAF4F2),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF161B1D)),
      bodyMedium: TextStyle(color: Color(0xFF5C6B70)),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121517),
    primaryColor: const Color(0xFF3FA9F5),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3FA9F5),
      secondary: Color(0xFF2EE6A3),
      surface: Color(0xFF1C2426),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFF5F7F8)),
      bodyMedium: TextStyle(color: Color(0xFF9AA6AA)),
    ),
  );
}
