class ProductModel {
  final String title;

  ProductModel({required this.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
    );
  }
}