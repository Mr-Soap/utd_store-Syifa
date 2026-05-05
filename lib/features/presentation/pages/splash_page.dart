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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color.fromARGB(255, 157, 154, 206),
            ],
            begin: Alignment.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon
                  Icon(
                    Icons.shopify_rounded,
                    color: Colors.amber,
                    size: 250,
                  ),
                      
                  const SizedBox(height: 10),
                      
                  //Judul
                  Text(
                    'UTD STORE - Syifa',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color:  Color(0xFF4F46E5),
                    ),
                  ),
                      
                  const SizedBox(height: 40),
                      
                  //Nama
                  Text(
                    'Syifa Sopian Nurdiansyah',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 57, 51, 167),
                    ),
                  ),
                      
                  //NIM-ku
                  Text(
                    'NIM : 20123049',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 81, 78, 145)
                    ),
                  ),
                      
                  const SizedBox(height: 90),
                      
                  //loading
                  CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                      
                  const SizedBox(height: 15),
                      
                  Text(
                    'Now Loading...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Created by Syifa Sopian",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}