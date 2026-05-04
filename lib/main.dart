import 'package:flutter/material.dart';
import 'package:utd_store/features/product/presentation/pages/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injector.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTD STORE - Syifa',
      theme: AppTheme.lightTheme,
      home: const SplashScreen()
    );
  }
}