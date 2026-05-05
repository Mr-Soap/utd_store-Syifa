import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injector.dart';
import '../../data/services/crypto_service.dart';
import '../../../core/utility/heavy_compute.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  int? result;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final crypto = sl<CryptoService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Hub'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //judul
              Text(
                "Realtime Bitcoin Price",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary
                ),
              ),

              //gambar btc
              Icon(Icons.currency_bitcoin, size: 490, color: Colors.amber),

              const SizedBox(height: 20),

              //btc
              StreamBuilder<double>(
                stream: crypto.getBitcoinPrice(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text('Gagal memuat data kripto');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return Text(
                    "BTC: \$${snapshot.data!.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),

              const SizedBox(height: 30),

              //isolate
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  const int lastNimDigit = 49;
                  final int loop = lastNimDigit * 10000000;

                  final res = await compute(heavyTask, loop);

                  setState(() {
                    result = res;
                    isLoading = false;
                  });

                  debugPrint("Hasil: $result");
                },
                child: const Text('Kalkulasi Pajak Kripto'),
              ),

              const SizedBox(height: 20),

              if (isLoading) const CircularProgressIndicator(),

              // 🔥 HASIL
              if (result != null)
                Text(
                  "Hasil kalkulasi: $result",
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
