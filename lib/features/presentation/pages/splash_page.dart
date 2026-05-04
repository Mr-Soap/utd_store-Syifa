import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injector.dart';
import '../../domain/services/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async{
    final splashService = sl<SplashService>();
    await splashService.execute();

    if (mounted) {
      context.go('/product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Icon(
              Icons.shopify_rounded,
              color: Colors.amber,
              size: 40,
            ),

            const SizedBox(height: 10),

            //text
            Text(
              'Syifa Sopian Nurdiansyah\nNIM : 20123049',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            //loading
            CircularProgressIndicator(
              strokeWidth: 3,
            ),

            const SizedBox(height: 5),

            Text(
              'Now Loading...',
              style: TextStyle(fontSize: 12),
              )
          ],
        ),
      ),
    );
  }
}