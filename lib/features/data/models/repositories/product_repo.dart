import '../product_model.dart';
import '../../services/api_service.dart';
import '../../../../core/di/injector.dart';

class ProductRepo {
  final ApiService apiService = sl<ApiService>();

  Future<List<ProductModel>> getProducts() async {
    final response = await apiService.getProducts();
    final List data = response.data;

    const int lastNimDigit = 9;

    return data.map((json) {
      String title = json['title'];

      if (lastNimDigit % 2 == 1) {
        title += " [Diskon 10%]";
      } else {
        title += " [Promo Ongkir]";
      }
      return ProductModel(
        id: json['id'],
        title: title,
        price: (json['price'] as num).toDouble(),
        image: json["image"],
        category: json["category"]
        );
    }).toList();
  }

  Future<ProductModel?> getProductById(String id) async{
    try {
      final response = await apiService.dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}