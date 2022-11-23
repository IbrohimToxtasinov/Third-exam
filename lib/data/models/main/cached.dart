class ProductFields {
  static String id = "id";
  static String count = "count";
  static String category_id = "category_id";
  static String name = "name";
  static String price = "price";
  static String priority = "priority";
  static String image_url = "image_url";
  static String description = "description";
}

class ProductModel {
  final int? id;
  final int count;
  final num category_id;
  final String name;
  final num price;
  final String image_url;
  final String description;

  ProductModel({
    this.id,
    required this.count,
    required this.category_id,
    required this.name,
    required this.price,
    required this.image_url,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? -1,
      count: json['count'] ?? -1,
      category_id: json['category_id'] ?? -1,
      name: json['name'] ?? '',
      price: json['price'] ?? -1,
      image_url: json['image_url'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count' : count,
      'category_id': category_id,
      'name': name,
      'price': price,
      'image_url': image_url,
      'description': description,
    };
  }

  ProductModel copyWith({
    int? id,
    int? count,
    num? category_id,
    String? name,
    num? price,
    String? image_url,
    String? description,
  }) =>
      ProductModel(
        id: id ?? this.id,
        count: count ?? this.count,
        category_id: category_id ?? this.category_id,
        name: name ?? this.name,
        price: price ?? this.price,
        image_url: image_url ?? this.image_url,
        description: description ?? this.description,
      );
}
