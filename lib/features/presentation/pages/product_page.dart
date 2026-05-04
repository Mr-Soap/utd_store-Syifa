import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/product_cubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(title: const Text("UTD STORE - Syifa")),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
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
              );
            } else {
              return const Center(child: Text("Error"));
            }
          },
        ),
      ),
    );
  }
}
