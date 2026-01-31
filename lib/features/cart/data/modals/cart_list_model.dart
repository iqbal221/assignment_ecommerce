// class CartListModel {
//   final String id;
//   final String title;
//   // final String? photo;
//   final List<String>? photo;
//   final int currentPrice;

//   CartListModel({
//     required this.id,
//     required this.title,
//     this.photo,
//     required this.currentPrice,
//   });

//   factory CartListModel.fromJson(Map<String, dynamic> json) {
//     return CartListModel(
//       id: json["_id"],
//       title: json["title"],
//       // photo: json["photos"][0] ?? "",
//       photo: List<String>.from(json["photos"]),
//       currentPrice: json["current_price"],
//     );
//   }
// }

class CartListModel {
  final String id;
  final String title;
  final List<String> photos;
  final List<String> colors;
  final int currentPrice;
  final int quantity;

  CartListModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.colors,
    required this.currentPrice,
    required this.quantity,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};

    return CartListModel(
      id: json['_id'] ?? '',
      title: product['title'] ?? '',
      photos: product['photos'] != null
          ? List<String>.from(product['photos'])
          : [],
      currentPrice: product['current_price'] ?? 0,
      quantity: json['quantity'] ?? 1,
      colors: json['colors'] ?? [],
    );
  }
}
