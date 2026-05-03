import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTD STORE - Syifa',
      home: Scaffold(
        body: Center(
          child: Text('data'),
        ),
      ),
    );
  }
}