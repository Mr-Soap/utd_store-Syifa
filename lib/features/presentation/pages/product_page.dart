import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
import 'package:utd_store/features/data/models/repositories/bookmark_repo.dart';
import '../cubit/product_cubit.dart';
import '../../../core/di/injector.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'UTD STORE - ',
                  style: GoogleFonts.montserrat(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  )
                ),
                TextSpan(
                  text: 'SYIFA',
                  style: GoogleFonts.montserrat(
                    color: AppColor.secondary,
                    fontWeight: FontWeight.bold
                  )
                ),
              ]
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              color: AppColor.background,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'bookmark') {
                  context.push('/bookmark');
                } else if (value == 'native') {
                  context.push('/native');
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'bookmark',
                  child: Row(
                    children: [
                      Icon(Icons.bookmark),
                      SizedBox(width: 10),
                      Text(
                        'Bookmark',
                        style: GoogleFonts.inter(color: AppColor.textPrimary),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'native',
                  child: Row(
                    children: [
                      Icon(Icons.phone_android),
                      SizedBox(width: 10),
                      Text(
                        'Native',
                        style: GoogleFonts.inter(color: AppColor.textPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return switch (state) {
              ProductLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              ProductLoaded(products: final listProducts) => ListView.builder(
                itemCount: listProducts.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color.fromARGB(69, 235, 211, 248),
                          ),
                        ),
                        child: ListTile(

                          //foto produk
                          leading: Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),

                          //nama produk
                          title: Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          //bookmark
                          trailing: IconButton(
                            icon: Icon(
                              Icons.bookmark_add,
                              color: Colors.lightGreen,
                            ),
                            onPressed: () {
                              final repo = sl<BookmarkRepo>();
                              repo.addBookmark(product.title);
                            },
                          ),

                          //id kategory dan harga
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "ID: ${product.id} • Kategori: ${product.category}",
                                  style: GoogleFonts.inter(
                                    color: AppColor.textSecondary,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                "\$${product.price}",
                                style: GoogleFonts.inter(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),

                          onTap: () {
                            context.push('/detail/${product.id}');
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              ProductError(message: final errorMsg) => Center(
                child: Text(
                  errorMsg,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            };
          },
        ),

        floatingActionButton: FloatingActionButton(
          tooltip: "Buka Crypto Hub",
          onPressed: () {
            context.push('/crypto');
          },
          backgroundColor: AppColor.secondary,
          foregroundColor: AppColor.background,
          elevation: 6,
          child: const Icon(Icons.currency_bitcoin),
        ),
      ),
    );
  }
}
