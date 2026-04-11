// models/user.dart
class User {
  final int id;
  final String email;
  final String googleId;
  final String name;
  final String profilePhoto;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.googleId,
    required this.name,
    required this.profilePhoto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      googleId: json['google_id'],
      name: json['name'],
      profilePhoto: json['profile_photo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
