class ProductModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;


  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category
  });

  double get discounted => price * 0.9;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image']??"",
      category: json['category']??"tidak ada kategori",
    );
  }
}