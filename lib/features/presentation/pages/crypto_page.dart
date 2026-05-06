import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
import '../../../core/di/injector.dart';
import '../../domain/services/crypto_service.dart';
import '../../../core/utility/heavy_compute.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  int? result;
  bool isLoading = false;
  List<double> priceHistory = [];
  double? lastPrice; // harga sebelumnya
  double? changePercent;

  @override
  Widget build(BuildContext context) {
    final crypto = sl<CryptoService>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Crypto Hub',
          style: GoogleFonts.montserrat(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                "Harga Bitcoin Realtime",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondary,
                ),
              ),

              const SizedBox(height: 15),

              //gambar btc
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.background,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.secondary.withValues(alpha: 0.6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.currency_bitcoin,
                  size: 390,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(height: 25),

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

                  if (snapshot.hasData) {
                    final price = snapshot.data!;

                    if (lastPrice != null) {
                      changePercent = ((price - lastPrice!) / lastPrice!) * 100;
                    }

                    lastPrice = price;

                    priceHistory.add(price);
                    if (priceHistory.length > 20) {
                      priceHistory.removeAt(0);
                    }
                  }

                  //hargabtc
                  return Column(
                    children: [
                      Text(
                        "BTC/USD",
                        style: GoogleFonts.inter(color: AppColor.textSecondary),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "\$${snapshot.data!.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: const Color.fromARGB(255, 250, 222, 109),
                              offset: Offset(0, 0),
                            ),
                            Shadow(
                              blurRadius: 25,
                              color: const Color.fromARGB(255, 143, 117, 16),
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5),

                      if (changePercent != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              changePercent! >= 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: changePercent! >= 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${changePercent!.toStringAsFixed(2)}%",
                              style: TextStyle(
                                color: changePercent! >= 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              //isolate
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(90, 235, 211, 248),
                    width: 1,
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                
                        const int lastNimDigit = 49;
                        final int loop = lastNimDigit * 10000000;
                
                        final res = await compute(heavyTask, loop);
                
                        setState(() {
                          result = res;
                          isLoading = false;
                        });
                
                        debugPrint("Hasil: $result");
                      },
                      child: Text(
                        'Kalkulasi Pajak Kripto',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                
                    const SizedBox(height: 20),

                    if (result == null)
                    Text(
                        "Hasil kalkulasi:",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColor.secondary,
                        ),
                      ),    
                
                    if (isLoading) const CircularProgressIndicator(),
                
                    //hasil kalkulasi
                    if (result != null)
                      Text(
                        "Hasil kalkulasi: $result",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColor.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
