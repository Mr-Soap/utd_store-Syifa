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
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                context.push('/bookmark');
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return switch(state) {
              ProductLoading() => const Center(child: CircularProgressIndicator()),
              ProductLoaded(products: final listProducts) => ListView.builder(
                itemCount: listProducts.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return ListTile(
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
                    title: Text(product.title),

                    //bookmark
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark_add),
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

                        Text("\$${product.price}"),
                        const SizedBox(width: 10),
                      ],
                    ),

                    onTap: () {
                      context.push('/detail/${product.id}');
                    },
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
      ),
    );
  }
}
