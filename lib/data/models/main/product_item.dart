class ProductsItem {
  num id;
  num categoryId;
  String name;
  num price;
  String imageUrl;
  String description;

  ProductsItem({
    required this.id,
    required this.categoryId,
    required this.name, 
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory ProductsItem.fromJson(Map<String, dynamic> jsonData) {
    num id = jsonData['id'] as num;
    num categoryId = jsonData['category_id'] as num;
    String name = jsonData['name'] as String;
    num price = jsonData['price'] as num;
    String imageUrl = jsonData['image_url'] as String;
    String description = jsonData['description'] as String;
  
    return ProductsItem(id: id, categoryId: categoryId, name: name, price: price, imageUrl: imageUrl, description: description);
  }
}