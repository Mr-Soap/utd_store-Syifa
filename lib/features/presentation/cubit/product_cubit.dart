import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/models/repositories/product_repo.dart';
import '../../../core/di/injector.dart';

sealed class ProductState {}

class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final List<ProductModel> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState{
  final String message;

  ProductError(this.message);
}

class ProductCubit extends Cubit<ProductState>{
  final ProductRepo repository = sl<ProductRepo>();

  ProductCubit() : super(ProductLoading());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    
    try {

      final products = await repository.getProducts();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}