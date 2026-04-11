// models/avatar.dart

class Avatar {
  final int id;
  final String imageUrl;

  Avatar({required this.id, required this.imageUrl});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}
