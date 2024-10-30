class UserModel {
  final String id;
  final String email;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'].toString(), // Ensure conversion to String
    );
  }
}
