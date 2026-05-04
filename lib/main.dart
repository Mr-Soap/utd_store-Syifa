import 'package:flutter/material.dart';
import 'package:utd_store/core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}