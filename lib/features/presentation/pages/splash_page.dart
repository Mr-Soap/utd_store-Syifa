import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
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

  Future<void> _start() async {
    final splashService = sl<SplashService>();
    await splashService.execute();

    if (mounted) {
      context.go('/product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
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
                  color: Color(0xFFFFCC00),
                  size: 250
                ),

                const SizedBox(height: 10),

                //Judul
                Text(
                  'UTD STORE - SYIFA',
                  style: GoogleFonts.montserrat(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),

                const SizedBox(height: 40),

                //Nama
                Text(
                  'Syifa Sopian Nurdiansyah',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textSecondary,
                  ),
                ),

                //NIM-ku
                Text(
                  'NIM : 20123049',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColor.textSecondary,
                  ),
                ),

                const SizedBox(height: 90),

                //loading
                CircularProgressIndicator(strokeWidth: 3),

                const SizedBox(height: 15),

                Text(
                  'Now Loading...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.loading,
                  ),
                ),
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
    );
  }
}
