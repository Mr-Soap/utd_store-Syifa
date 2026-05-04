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
              size: 150,
            ),

            const SizedBox(height: 10),

            //Judul
            Text(
              'UTD STORE - Syifa',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 10),

            //Nama
            Text(
              'Syifa Sopian Nurdiansyah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),

            //NIM-ku
            Text(
              'NIM : 20123049',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 60),

            //loading
            CircularProgressIndicator(
              strokeWidth: 3,
            ),

            const SizedBox(height: 10),

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