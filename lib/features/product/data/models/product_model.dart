class ProductModel {
  final String id;
  final String title;
  final String? photo;
  final int currentPrice;

  ProductModel({
    required this.id,
    required this.title,
    this.photo,
    required this.currentPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"],
      title: json["title"],
      photo: json["photos"][0] ?? "",
      currentPrice: json["current_price"],
    );
  }
}
