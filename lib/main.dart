import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/onboarding/welcome_screen.dart';

void main() {
  runApp(const HealthyEatsApp());
}

class HealthyEatsApp extends StatelessWidget {
  const HealthyEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyEats',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
} 