import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        title: const Text("Native Integration"),
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
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              //icon baterai
              Icon(
                Icons.battery_unknown,
                size: 390,
                color: const Color.fromARGB(255, 39, 214, 45),
              ),

              Text(
                "Battery: $batteryLevel%",
                style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 39, 214, 45)),
              ),

              const SizedBox(height: 20),

              //button batre
              ElevatedButton(
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
                child: const Text('Cek Baterai'),
              ),

              //showtoast
              ElevatedButton(
                onPressed: () async {
                  await native.showNativeToast("Hello dari developer");
                },
                child: const Text('Tampilkan Toast'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
