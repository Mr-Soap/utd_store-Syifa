import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_repo.dart';
import '../../../core/di/injector.dart';

abstract class ProductState {}

class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final List<ProductModel> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState{}

class ProductCubit extends Cubit<ProductState>{
  final ProductRepo repository = sl<ProductRepo>();

  ProductCubit() : super(ProductLoading());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());

      final products = await repository.getProducts();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError());
    }
  }
}