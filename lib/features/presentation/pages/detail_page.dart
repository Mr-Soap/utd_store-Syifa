import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
import '../../../core/di/injector.dart';
import '../../data/services/product_service.dart';

class DetailPage extends StatelessWidget {
  final String productId;
  const DetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final service = sl<ProductService>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Produk',
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
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              context.push('/bookmark');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: service.fetchProductDetail(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Produk tidak ditemukan"));
          }

          final product = snapshot.data!;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //kategori
                    Text(
                      product.category.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //foto produk
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.secondary.withValues(alpha: 0.1),
                                Colors.transparent,
                                AppColor.secondary.withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                          child: Image.network(
                            product.image,
                            width: 500,
                            height: 500,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, size: 80),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    //id
                    Text(
                      'ID Produk: ${product.id}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColor.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //nama produk
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //harga
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F1E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDAA300),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
