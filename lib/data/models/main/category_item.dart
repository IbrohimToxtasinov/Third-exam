class CategoryItem {
  num id;
  String name;
  String imageUrl;
  String createdAt;

  CategoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> jsonData) {
    num id = jsonData['id'] as num;
    String name = jsonData['name'] as String;
    String imageUrl = jsonData['image_url'] as String;
    String createdAt = jsonData['created_at'] as String;

    return CategoryItem(
        id: id, name: name, imageUrl: imageUrl, createdAt: createdAt);
  }
}
