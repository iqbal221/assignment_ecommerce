class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? avatar;
  final String city;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.avatar,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar_url'] ?? "",
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'avatar_url': avatar,
      'city': city,
    };
  }
}
