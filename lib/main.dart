import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const StayConnectedApp());
}

class StayConnectedApp extends StatefulWidget {
  const StayConnectedApp({super.key});

  @override
  State<StayConnectedApp> createState() => _StayConnectedAppState();
}

class _StayConnectedAppState extends State<StayConnectedApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StayConnected',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: SplashScreen(onToggleTheme: toggleTheme),
    );
  }
}