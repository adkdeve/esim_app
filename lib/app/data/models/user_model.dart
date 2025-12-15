class UserModel {
  final int? userId;
  final String? userLogin;
  final String? userEmail;
  late final String? displayName;
  final List<String>? roles;
  final String? dob;

  UserModel({
    this.userId,
    this.userLogin,
    this.userEmail,
    this.displayName,
    this.roles,
    this.dob,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userLogin: json['user_login'],
      userEmail: json['user_email'],
      displayName: json['display_name'],
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      dob: json['dob'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_login': userLogin,
      'user_email': userEmail,
      'display_name': displayName,
      'roles': roles,
      'dob': dob,
    };
  }
}