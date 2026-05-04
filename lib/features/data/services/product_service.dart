import '../../data/models/product_repo.dart';
import '../../data/models/product_model.dart';

class ProductService {
  final ProductRepo repository;
  ProductService(this.repository);

  Future<List<ProductModel>> fetchProducts() {
    return repository.getProducts();
  }
  
  Future<ProductModel?> fetchProductDetail(String id) {
    return repository.getProductById(id);
  }
}