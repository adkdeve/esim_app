class SubCategoryModel {
  final String uid;
  final String name;
  final String image;
  final String price;
  final String category_id;

  SubCategoryModel({
    required this.uid,
    required this.name,
    required this.image,
    required this.price,
    required this.category_id,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      uid: (json['id'] ?? json['uid'])?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Plan',
      image: json['image']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      category_id: json['category_id']?.toString() ?? '',
    );
  }

}