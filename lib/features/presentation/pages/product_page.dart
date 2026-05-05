import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          title: const Text("UTD STORE - Syifa"),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'bookmark') {
                  context.push('/bookmark');
                } else if (value == 'native') {
                  context.push('/native');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'bookmark', child: Text('Bookmark')),
                const PopupMenuItem(value: 'native', child: Text('Native')),
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
                      ListTile(
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
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                            Text("ID: ${product.id}"),
                            const SizedBox(width: 10),
                            Text("Kategori: ${product.category}"),

                            const Spacer(),

                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),

                        onTap: () {
                          context.push('/detail/${product.id}');
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          thickness: 0.8,
                          color: Colors.grey.withValues(alpha: 0.3),
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
          backgroundColor: const Color(0xFF667EEA),
          foregroundColor: Colors.white,
          elevation: 6,
          child: const Icon(Icons.currency_bitcoin),
        ),
      ),
    );
  }
}
