class CategoryModel {
  final String uid;
  final String name;
  final String image;
  final String price;

  CategoryModel({
    required this.uid,
    required this.name,
    required this.image,
    required this.price,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      uid: json['uid']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Plan',
      image: json['image']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
    );
  }

}