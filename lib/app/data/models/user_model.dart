class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['user_id']?.toString() ?? '',
    name: json['user_login'],
    email: json['user_email'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': id,
    'user_login': name,
    'user_email': email,
  };
}
