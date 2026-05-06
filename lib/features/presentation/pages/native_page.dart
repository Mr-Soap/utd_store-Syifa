import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
import '../../../core/di/injector.dart';
import '../../domain/services/native_service.dart';

class NativePage extends StatefulWidget {
  const NativePage({super.key});

  @override
  State<NativePage> createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  int? batteryLevel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final native = sl<NativeService>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Native Integration",
          style: GoogleFonts.montserrat(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //info batre
              Text(
                "Status Baterai",
                style: GoogleFonts.poppins(
                  fontSize: 39,
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              //icon baterai
              Icon(
                Icons.battery_unknown,
                size: 390,
                color: const Color(0xFF27D62D),
              ),

              Text(
                "Battery: $batteryLevel%",
                style: GoogleFonts.inter(
                  fontSize: 25,
                  color: Color(0xFF27D62D),
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: Color(0xFF27D62D),
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      blurRadius: 25,
                      color: Color(0xFF147017),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //button batre
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.textSecondary,
                  foregroundColor: const Color(0xFF1A0061),
                  minimumSize: const Size(450, 50),
                  elevation: 0, //
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  final result = await native.getBatteryLevel();

                  if (mounted) {
                    setState(() {
                      batteryLevel = result;
                      isLoading = false;
                    });
                  }
                },
                child: Text(
                  'Cek Baterai',
                  style: GoogleFonts.inter(
                    color: AppColor.background,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //showtoast
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.textSecondary,
                  foregroundColor: const Color(0xFF1A0061),
                  minimumSize: const Size(450, 50),
                  elevation: 0, //
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await native.showNativeToast("Hello dari developer");
                },
                child: Text(
                  'Tampilkan Toast',
                  style: GoogleFonts.inter(
                    color: AppColor.background,
                    fontWeight: FontWeight.w600,
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
